




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniversalLoader extends StatefulWidget {
  @override
  _UniversalLoaderState createState() => _UniversalLoaderState();
}
class _UniversalLoaderState extends State<UniversalLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54, // Dim background
      child: Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black), // Change color if needed
            ),
          ),
        ),
      ),
    );
  }
}