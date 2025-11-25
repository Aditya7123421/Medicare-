// lib/screens/calendar_screen.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<Map<String, String>> healthEvents = [
    {'date': '2024-01-10', 'type': 'blood-test', 'title': 'CBC Test', 'description': 'Complete Blood Count'},
    {'date': '2024-01-15', 'type': 'prescription', 'title': 'Aspirin', 'description': '500mg, Twice daily'},
    {'date': '2024-01-20', 'type': 'blood-test', 'title': 'Metabolic Panel', 'description': 'Glucose, Creatinine, Sodium'},
    {'date': '2023-12-20', 'type': 'blood-test', 'title': 'Lipid Panel', 'description': 'Cholesterol levels'},
    {'date': '2023-11-20', 'type': 'prescription', 'title': 'Lisinopril', 'description': '10mg, Once daily'},
  ];

  DateTime currentDate = DateTime(2024, 1, 1);

  int getDaysInMonth(DateTime date) => DateTime(date.year, date.month + 1, 0).day;
  int getFirstWeekdayOfMonth(DateTime date) {
    final weekday = DateTime(date.year, date.month, 1).weekday; // Mon=1..Sun=7
    return weekday % 7; // convert to Sun=0..Sat=6
  }

  List<Map<String, String>> eventsForDate(DateTime date) {
    final dateString = date.toIso8601String().split('T')[0];
    return healthEvents.where((e) => e['date'] == dateString).toList();
  }

  void previousMonth() => setState(() => currentDate = DateTime(currentDate.year, currentDate.month - 1, 1));
  void nextMonth() => setState(() => currentDate = DateTime(currentDate.year, currentDate.month + 1, 1));

  String monthTitle(DateTime date) {
    const names = [
      'January','February','March','April','May','June','July','August','September','October','November','December'
    ];
    return '${names[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLarge = width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.blue.shade200, borderRadius: BorderRadius.circular(8)), child: const Center(child: Text('H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 12),
          const Text('HealthHub'),
        ]),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)), IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline))],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 92),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.green.shade50]), border: Border.all(color: Colors.blue.withOpacity(0.18))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Health Calendar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Track all your prescriptions and blood tests on a calendar', style: TextStyle(color: Colors.black54)),
              ]),
            ),
            const SizedBox(height: 16),
            isLarge ? _buildLargeLayout() : _buildSmallLayout(),
          ]),
        ),
      ),
    );
  }

  Widget _buildLargeLayout() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(flex: 2, child: _buildCalendarCard()),
      const SizedBox(width: 16),
      Expanded(flex: 1, child: _buildSidebar()),
    ]);
  }

  Widget _buildSmallLayout() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildCalendarCard(),
      const SizedBox(height: 12),
      _buildSidebar(),
    ]);
  }

  Widget _buildCalendarCard() {
    final daysInMonth = getDaysInMonth(currentDate);
    final firstWeekday = getFirstWeekdayOfMonth(currentDate);
    final emptySlots = List<int>.generate(firstWeekday, (i) => i);
    final days = List<int>.generate(daysInMonth, (i) => i + 1);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            OutlinedButton(onPressed: previousMonth, child: const Icon(Icons.chevron_left_outlined)),
            Text(monthTitle(currentDate), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            OutlinedButton(onPressed: nextMonth, child: const Icon(Icons.chevron_right_outlined)),
          ]),
          const SizedBox(height: 8),
          Row(children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((d) => Expanded(child: Center(child: Text(d, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54))))).toList()),
          const SizedBox(height: 8),
          // GridView.count ensures stable sizing on small screens
          LayoutBuilder(builder: (context, constraints) {
            final children = <Widget>[];
            for (var _ in emptySlots) children.add(Container());
            for (var day in days) {
              final date = DateTime(currentDate.year, currentDate.month, day);
              final events = eventsForDate(date);
              children.add(_CalendarDayCell(date: date, events: events));
            }

            return GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              children: children,
            );
          }),
        ]),
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
        color: Colors.blue.shade50.withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Legend', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Row(children: [Icon(Icons.medication, size: 18, color: Colors.blue), SizedBox(width: 8), Text('Prescription', style: TextStyle(color: Colors.black54))]),
            SizedBox(height: 8),
            Row(children: [Icon(Icons.opacity, size: 18, color: Colors.green), SizedBox(width: 8), Text('Blood Test', style: TextStyle(color: Colors.black54))]),
          ]),
        ),
      ),
      const SizedBox(height: 12),
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text('Recent Events', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...healthEvents.take(6).map((e) {
              final parsedDate = DateTime.tryParse(e['date']!);
              final displayDate = parsedDate != null ? '${_monthAbbr(parsedDate.month)} ${parsedDate.day}' : e['date'];
              return Column(children: [
                const SizedBox(height: 8),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(e['type'] == 'blood-test' ? Icons.opacity : Icons.medication, color: e['type'] == 'blood-test' ? Colors.green : Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(e['description']!, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(displayDate.toString(), style: const TextStyle(color: Colors.black45, fontSize: 12)),
                  ])),
                ]),
                const Divider(),
              ]);
            }).toList(),
          ]),
        ),
      ),
    ]);
  }

  String _monthAbbr(int m) {
    const names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return names[m - 1];
  }
}

class _CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final List<Map<String, String>> events;

  const _CalendarDayCell({Key? key, required this.date, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasEvents = events.isNotEmpty;
    final bgColor = hasEvents ? Colors.green.shade50 : Colors.grey.shade50;
    final borderColor = hasEvents ? Colors.green.shade100 : Colors.grey.shade200;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: borderColor)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${date.day}', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        if (events.isNotEmpty) ...[
          for (var i = 0; i < math.min(events.length, 2); i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(children: [
                Icon(events[i]['type'] == 'blood-test' ? Icons.opacity : Icons.medication, size: 14, color: events[i]['type'] == 'blood-test' ? Colors.green : Colors.blue),
                const SizedBox(width: 6),
                Expanded(child: Text(events[i]['title']!, style: const TextStyle(fontSize: 11, color: Colors.black54), overflow: TextOverflow.ellipsis)),
              ]),
            ),
          if (events.length > 2) Text('+${events.length - 2} more', style: const TextStyle(fontSize: 11, color: Colors.black45)),
        ]
      ]),
    );
  }
}
