import 'package:flutter/material.dart';

class PrescriptionCard extends StatelessWidget {
  final String medication;
  final String dosage;
  final String frequency;
  final String startDate;
  final String endDate;
  final String doctor;

  const PrescriptionCard({
    Key? key,
    required this.medication,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.doctor,
  }) : super(key: key);

  bool get isActive {
    if (endDate == 'Ongoing') return true;
    try {
      return DateTime.parse(endDate).isAfter(DateTime.now());
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.medication, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(medication,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(dosage, style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                Chip(
                  label: Text(isActive ? 'Active' : 'Inactive'),
                  backgroundColor:
                      isActive ? Colors.blue.shade100 : Colors.grey.shade200,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Frequency',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12)),
                      const SizedBox(height: 6),
                      Text(frequency,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Doctor',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12)),
                      const SizedBox(height: 6),
                      Text(doctor,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),

            Text('$startDate to $endDate',
                style: const TextStyle(fontSize: 12, color: Colors.black54)),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Remove'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
