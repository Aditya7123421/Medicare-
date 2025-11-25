// lib/screens/upload_record_screen.dart

import 'package:flutter/material.dart';

class UploadRecordScreen extends StatelessWidget {
  final String type;
  const UploadRecordScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload $type Record"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Text("Upload UI for '$type' goes here",
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
