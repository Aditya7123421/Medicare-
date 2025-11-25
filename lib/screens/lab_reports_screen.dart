import 'package:flutter/material.dart';
import '../widgets/blood_test_card.dart';

class LabReportsScreen extends StatelessWidget {
  const LabReportsScreen({Key? key}) : super(key: key);

  // ---- SAMPLE DATA (replace later with backend data) ----
  List<Map<String, dynamic>> get sampleTests => [
        {
          'testName': 'Complete Blood Count (CBC)',
          'lab': 'City Medical Lab',
          'date': '2024-01-10',
          'results': [
            {'name': 'RBC', 'value': '4.8', 'unit': 'M/µL', 'status': 'normal'},
            {'name': 'WBC', 'value': '7.2', 'unit': 'K/µL', 'status': 'normal'},
            {'name': 'Hemoglobin', 'value': '14.5', 'unit': 'g/dL', 'status': 'normal'},
          ],
        },
        {
          'testName': 'Metabolic Panel',
          'lab': 'City Medical Lab',
          'date': '2024-01-10',
          'results': [
            {'name': 'Glucose', 'value': '95', 'unit': 'mg/dL', 'status': 'normal'},
            {'name': 'Creatinine', 'value': '0.9', 'unit': 'mg/dL', 'status': 'normal'},
            {'name': 'Sodium', 'value': '138', 'unit': 'mEq/L', 'status': 'normal'},
          ],
        },
        {
          'testName': 'Lipid Panel',
          'lab': 'Labs Plus',
          'date': '2023-12-20',
          'results': [
            {'name': 'Total Cholesterol', 'value': '195', 'unit': 'mg/dL', 'status': 'high'},
            {'name': 'LDL', 'value': '115', 'unit': 'mg/dL', 'status': 'normal'},
            {'name': 'HDL', 'value': '50', 'unit': 'mg/dL', 'status': 'normal'},
          ],
        },
        {
          'testName': 'Thyroid Function Test',
          'lab': 'DiagnoHub',
          'date': '2023-11-15',
          'results': [
            {'name': 'TSH', 'value': '2.1', 'unit': 'mIU/L', 'status': 'normal'},
            {'name': 'T3', 'value': '120', 'unit': 'ng/dL', 'status': 'normal'},
            {'name': 'T4', 'value': '8.5', 'unit': 'ng/dL', 'status': 'normal'},
          ],
        },
      ];

  @override
  Widget build(BuildContext context) {
    final tests = sampleTests;

    final lastDate = tests.isNotEmpty ? tests.first['date'] : '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Blood Tests"),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "View and track all your blood test results and health metrics",
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 20),

            // Search + Upload Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search by test name or lab...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Upload Test"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _StatCard(title: "Total Tests", value: tests.length.toString()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(title: "Last Test Date", value: lastDate),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Existing BloodTestCards
            ...tests.map((t) {
              return BloodTestCard(
                testName: t['testName'],
                lab: t['lab'],
                date: t['date'],
                results: List<Map<String, String>>.from(t['results']),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
