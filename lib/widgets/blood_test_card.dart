// lib/widgets/blood_test_card.dart
import 'package:flutter/material.dart';

class BloodTestCard extends StatelessWidget {
  final String testName;
  final String date;
  final String lab;
  final List<Map<String, String>> results;

  const BloodTestCard({
    Key? key,
    required this.testName,
    required this.date,
    required this.lab,
    required this.results,
  }) : super(key: key);

  Color _statusColor(String status) {
    switch (status) {
      case 'high':
        return Colors.red.shade100;
      case 'low':
        return Colors.orange.shade100;
      default:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.opacity, color: Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(testName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(lab, style: const TextStyle(color: Colors.black54)),
            ])),
          ]),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            child: Column(children: results.map((r) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Flexible(child: Text(r['name']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: _statusColor(r['status']!), borderRadius: BorderRadius.circular(6)),
                    child: Text('${r['value']} ${r['unit']}', style: const TextStyle(fontSize: 12)),
                  ),
                ]),
              );
            }).toList()),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 6),
          Text('Tested on $date', style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text('Download Report'),
            ),
          ),
        ]),
      ),
    );
  }
}
