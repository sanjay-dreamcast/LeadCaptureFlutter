import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

class DigestAuthClient extends http.BaseClient {
  DigestAuthClient(String username, String password, {inner})
      : _auth = DigestAuth(username, password),
        // ignore: prefer_if_null_operators
        _inner = inner == null ? http.Client() : inner;
  final http.Client _inner;
  final DigestAuth _auth;

  void _setAuthString(http.BaseRequest request) {
    request.headers['Authorization'] =
        _auth.getAuthString(request.method, request.url);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll(request.headers);

    //var response = await client.send(this);
    final response = await _inner.send(request);

    if (response.statusCode == 401) {
      final newRequest = copyRequest(request);
      var authInfo = response.headers['WWW-Authenticate'];
      _auth.initFromAuthorizationHeader(authInfo == null ? "" : authInfo);
      _setAuthString(newRequest);
      return _inner.send(newRequest);
    }

    // we should reach this point only with errors other than 401
    return response;
  }
}

Map<String, String> splitAuthenticateHeader(String header) {
  if (header == null || !header.startsWith('Digest ')) {
    Map<String, String> values = new Map<String, String>();
    return values;
  }
  String token = header.substring(7); // remove 'Digest '

  var ret = <String, String>{};

  final components = token.split(',').map((token) => token.trim());
  for (final component in components) {
    final kv = component.split('=');
    ret[kv[0]] = kv.getRange(1, kv.length).join('=').replaceAll('"', '');
  }
  return ret;
}

String md5Hash(String data) {
  var content = const Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content).toString();
  return digest;
}

// from http_retry
/// Returns a copy of [original].
http.Request _copyNormalRequest(http.Request original) {
  var request = http.Request(original.method, original.url)
    ..followRedirects = original.followRedirects
    ..persistentConnection = original.persistentConnection
    ..body = original.body;
  request.headers.addAll(original.headers);
  request.maxRedirects = original.maxRedirects;

  return request;
}

http.BaseRequest copyRequest(http.BaseRequest original) {
  if (original is http.Request) {
    return _copyNormalRequest(original);
  } else {
    throw UnimplementedError(
        'cannot handle yet requests of type ${original.runtimeType}');
  }
}

// Digest auth

String _formatNonceCount(int nc) {
  return nc.toRadixString(16).padLeft(8, '0');
}

String _computeHA1(String realm, String algorithm, String username,
    String password, String nonce, String cnonce) {
  String ha1 = '';

  if (algorithm == null || algorithm == 'MD5') {
    final token1 = "$username:$realm:$password";
    ha1 = md5Hash(token1);
  } else if (algorithm == 'MD5-sess') {
    final token1 = "$username:$realm:$password";
    final md51 = md5Hash(token1);
    final token2 = "$md51:$nonce:$cnonce";
    ha1 = md5Hash(token2);
  }

  return ha1;
}

Map<String, String> computeResponse(
    String method,
    String path,
    String body,
    String algorithm,
    String qop,
    String opaque,
    String realm,
    String cnonce,
    String nonce,
    int nc,
    String username,
    String password) {
  var ret = <String, String>{};

  // ignore: non_constant_identifier_names
  String HA1 = _computeHA1(realm, algorithm, username, password, nonce, cnonce);

  // ignore: non_constant_identifier_names
  String HA2;

  if (qop == 'auth-int') {
    final bodyHash = md5Hash(body);
    final token2 = "$method:$path:$bodyHash";
    HA2 = md5Hash(token2);
  } else {
    // qop in [null, auth]
    final token2 = "$method:$path";
    HA2 = md5Hash(token2);
  }

  final nonceCount = _formatNonceCount(nc);
  ret['username'] = username;
  ret['realm'] = realm;
  ret['nonce'] = nonce;
  ret['uri'] = path;
  ret['qop'] = qop;
  ret['nc'] = nonceCount;
  ret['cnonce'] = cnonce;
  if (opaque != null) {
    ret['opaque'] = opaque;
  }
  ret['algorithm'] = algorithm;

  if (qop == null) {
    final token3 = "$HA1:$nonce:$HA2";
    ret['response'] = md5Hash(token3);
  } else if (qop == 'auth' || qop == 'auth-int') {
    final token3 = "$HA1:$nonce:$nonceCount:$cnonce:$qop:$HA2";
    ret['response'] = md5Hash(token3);
  }

  return ret;
}

class DigestAuth {
  DigestAuth(this.username, this.password);

  String username;
  String password;

  // must get from first response
  String _algorithm = 'MD5';
  String _qop = 'auth';
  String _realm = 'Restricted area';
  String _nonce =
      '4d6a41794d6a417a4d6a51784d6a49304d5441324d6a4e6a4e6a4a6c5957566c4d7a4a6a';
  String _opaque = 'fa53b91ccc1b78668d5af58e1ed3a485';

  int _nc = 0; // request counter
  String _cnonce = ''; // client-generated; should change for each request

  String _computeNonce() {
    math.Random rnd = math.Random();

    List<int> values = List<int>.generate(16, (i) => rnd.nextInt(256));

    return ""; //return hex.encode(values);
  }

  String getAuthString(String method, Uri url) {
    _cnonce = _computeNonce();
    _nc += 1;
    // if url has query parameters, append query to path
    var path = url.hasQuery ? "${url.path}?${url.query}" : url.path;

    // after the first request we have the nonce, so we can provide credentials
    var authValues = computeResponse(method, path, '', _algorithm, _qop,
        _opaque, _realm, _cnonce, _nonce, _nc, username, password);
    final authValuesString = authValues.entries
        .where((e) => e.value != null)
        .map((e) => [e.key, '="', e.value, '"'].join(''))
        .toList()
        .join(', ');
    final authString = 'Digest $authValuesString';
    return authString;
  }

  void initFromAuthorizationHeader(String authInfo) {
    Map<String, String> values = splitAuthenticateHeader(authInfo);

    if (values.length > 0) {
      _algorithm = values['algorithm']!;
      _qop = values['qop']!;
      _realm = values['realm']!;
      _nonce = values['nonce']!;
      _opaque = values['opaque']!;
    }
  }

  bool isReady() {
    return _nonce != null;
  }
}
