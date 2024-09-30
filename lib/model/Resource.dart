




import 'Status.dart';

// class Resource<T> {
//   final Status status;
//   final T? data;
//   final String? message;
//
//   Resource._({required this.status, this.data, this.message});
//
//   factory Resource.loading() => Resource._(status: Status.loading);
//   factory Resource.success(T data) => Resource._(status: Status.success, data: data);
//   factory Resource.error(String message,) => Resource._(status: Status.error, message: message,data: data);
// }

class Resource<T> {
  final Status status;
  final T? data;
  final String? message;

  Resource._({required this.status, this.data, this.message});

  // Loading state: Accepts optional data and message (default null)
  factory Resource.loading({T? data, String? message}) =>
      Resource._(status: Status.loading, data: data, message: message);

  // Success state: Accepts both data and optional message (default null)
  factory Resource.success(T data, {String? message}) =>
      Resource._(status: Status.success, data: data, message: message);

  // Error state: Accepts both error message and optional data (default null)
  factory Resource.error(String message, {T? data}) =>
      Resource._(status: Status.error, data: data, message: message);

  // Initial state: Represents the state before any API call
  factory Resource.initial() =>
      Resource._(status: Status.initial, data: null, message: null);
}
