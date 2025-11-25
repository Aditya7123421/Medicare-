// lib/screens/prescriptions_screen.dart
import 'package:flutter/material.dart';
import '../widgets/prescription_card.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({Key? key}) : super(key: key);

  List<Map<String, String>> get samplePrescriptions => [
        {
          'medication': 'Aspirin',
          'dosage': '500mg',
          'frequency': 'Twice daily',
          'startDate': '2024-01-15',
          'endDate': '2024-03-15',
          'doctor': 'Dr. Smith',
        },
        {
          'medication': 'Metformin',
          'dosage': '850mg',
          'frequency': 'Once daily',
          'startDate': '2023-06-01',
          'endDate': 'Ongoing',
          'doctor': 'Dr. Johnson',
        },
        {
          'medication': 'Lisinopril',
          'dosage': '10mg',
          'frequency': 'Once daily',
          'startDate': '2023-11-20',
          'endDate': 'Ongoing',
          'doctor': 'Dr. Williams',
        },
        {
          'medication': 'Atorvastatin',
          'dosage': '20mg',
          'frequency': 'Once at bedtime',
          'startDate': '2023-09-10',
          'endDate': 'Ongoing',
          'doctor': 'Dr. Smith',
        },
        {
          'medication': 'Omeprazole',
          'dosage': '20mg',
          'frequency': 'Once daily before breakfast',
          'startDate': '2024-02-01',
          'endDate': 'Ongoing',
          'doctor': 'Dr. Martinez',
        },
        {
          'medication': 'Vitamin D3',
          'dosage': '2000 IU',
          'frequency': 'Once daily',
          'startDate': '2023-12-15',
          'endDate': 'Ongoing',
          'doctor': 'Dr. Williams',
        },
      ];

  @override
  Widget build(BuildContext context) {
    final items = samplePrescriptions;
    final activeCount = items.where((p) => p['endDate'] == 'Ongoing').length;
    final inactiveCount = items.length - activeCount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: Row(children: [
          CircleAvatar(backgroundColor: Colors.indigo[100], child: Text('H', style: TextStyle(color: Colors.indigo))),
          const SizedBox(width: 12),
          const Text('Your Prescriptions', style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 6),
              const Text('Manage and track all your active and past prescriptions', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              // search + add
              Row(children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search by medication or doctor...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add Prescription'),
                ),
              ]),

              const SizedBox(height: 16),

              // stats row
              Row(children: [
                Expanded(child: _StatCard(title: 'Total Prescriptions', value: items.length.toString())),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(title: 'Active', value: activeCount.toString(), color: Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(title: 'Inactive', value: inactiveCount.toString())),
              ]),

              const SizedBox(height: 16),

              // grid of prescription cards (responsive)
              LayoutBuilder(builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.2,
                  children: items.map((p) {
                    return PrescriptionCard(
                      medication: p['medication'] ?? '',
                      dosage: p['dosage'] ?? '',
                      frequency: p['frequency'] ?? '',
                      startDate: p['startDate'] ?? '',
                      endDate: p['endDate'] ?? '',
                      doctor: p['doctor'] ?? '',
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  const _StatCard({Key? key, required this.title, required this.value, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? Colors.indigo;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 24, color: displayColor, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
