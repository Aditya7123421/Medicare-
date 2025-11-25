// lib/screens/photo_record_screen.dart

import 'package:flutter/material.dart';

class PhotoRecordScreen extends StatelessWidget {
  final String type;
  const PhotoRecordScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take Photo - $type"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Text("Camera view for '$type' goes here",
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
