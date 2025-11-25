// lib/screens/add_record_screen.dart

import 'package:flutter/material.dart';
import 'upload_record_screen.dart';
import 'photo_record_screen.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  String? selectedType;

  final List<Map<String, dynamic>> recordTypes = [
    {
      'id': 'prescription',
      'title': 'Add Prescription',
      'icon': Icons.description_outlined,
      'color': Colors.deepPurple,
    },
    {
      'id': 'lab-report',
      'title': 'Add Lab Report',
      'icon': Icons.opacity_outlined,
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Record"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Add New Record",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Select the type of record you want to add",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Record Options
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return GridView.count(
                crossAxisCount: isWide ? 2 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: recordTypes.map((type) {
                  bool active = selectedType == type['id'];

                  return GestureDetector(
                    onTap: () => setState(() => selectedType = type['id']),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: active ? Colors.deepPurple : Colors.grey.shade300,
                          width: active ? 2 : 1,
                        ),
                        color: active
                            ? Colors.deepPurple.shade50
                            : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: type['color'].withOpacity(0.15),
                            child: Icon(type['icon'], color: type['color'], size: 28),
                          ),
                          const SizedBox(height: 16),
                          Text(type['title'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          const Text(
                            "Choose how you want to add this record",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          // Methods (Upload/Take Photo)
          if (selectedType != null) ...[
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "${recordTypes.firstWhere((t) => t['id'] == selectedType)['title']} - Choose Method",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Buttons
                LayoutBuilder(builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  return GridView.count(
                    crossAxisCount: isWide ? 2 : 1,
                    shrinkWrap: true,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Upload
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UploadRecordScreen(type: selectedType!)),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.teal, width: 1.5),
                            color: Colors.teal.shade50,
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.upload_file, size: 28, color: Colors.teal),
                              SizedBox(height: 12),
                              Text("Upload from Drive",
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(height: 4),
                              Text("Upload PDF or image files",
                                  style: TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),

                      // Take Photo
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PhotoRecordScreen(type: selectedType!)),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.teal, width: 1.5),
                            color: Colors.teal.shade50,
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.camera_alt_outlined,
                                  size: 28, color: Colors.teal),
                              SizedBox(height: 12),
                              Text("Take Photo",
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(height: 4),
                              Text("Capture using your camera",
                                  style: TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ]),
            ),
          ],
        ]),
      ),
    );
  }
}
