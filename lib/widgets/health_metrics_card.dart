// lib/widgets/health_metrics_card.dart
import 'package:flutter/material.dart';

class HealthMetricsCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String icon;

  const HealthMetricsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // set a min height so mobile cards don't collapse awkwardly
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(unit, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ]),
            ),
            Text(icon, style: const TextStyle(fontSize: 32)),
          ]),
        ),
      ),
    );
  }
}
