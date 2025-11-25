// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../widgets/health_metrics_card.dart';
import '../widgets/prescription_card.dart';
import '../widgets/blood_test_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final prescriptions = [
    {
      "medication": "Aspirin",
      "dosage": "500mg",
      "frequency": "Twice daily",
      "startDate": "2024-01-15",
      "endDate": "2024-03-15",
      "doctor": "Dr. Smith"
    },
    {
      "medication": "Metformin",
      "dosage": "850mg",
      "frequency": "Once daily",
      "startDate": "2023-06-01",
      "endDate": "Ongoing",
      "doctor": "Dr. Johnson"
    },
    {
      "medication": "Lisinopril",
      "dosage": "10mg",
      "frequency": "Once daily",
      "startDate": "2023-11-20",
      "endDate": "Ongoing",
      "doctor": "Dr. Williams"
    },
    {
      "medication": "Atorvastatin",
      "dosage": "20mg",
      "frequency": "Once at bedtime",
      "startDate": "2023-09-10",
      "endDate": "Ongoing",
      "doctor": "Dr. Smith"
    },
  ];

  final bloodTests = [
    {
      "testName": "Complete Blood Count (CBC)",
      "date": "2024-01-10",
      "lab": "City Medical Lab",
      "results": [
        {"name": "RBC", "value": "4.8", "unit": "M/µL", "status": "normal"},
        {"name": "WBC", "value": "7.2", "unit": "K/µL", "status": "normal"},
        {"name": "Hemoglobin", "value": "14.5", "unit": "g/dL", "status": "normal"},
      ]
    },
    {
      "testName": "Metabolic Panel",
      "date": "2024-01-10",
      "lab": "City Medical Lab",
      "results": [
        {"name": "Glucose", "value": "95", "unit": "mg/dL", "status": "normal"},
        {"name": "Creatinine", "value": "0.9", "unit": "mg/dL", "status": "normal"},
        {"name": "Sodium", "value": "138", "unit": "mEq/L", "status": "normal"},
      ]
    },
    {
      "testName": "Lipid Panel",
      "date": "2023-12-20",
      "lab": "Labs Plus",
      "results": [
        {"name": "Total Cholesterol", "value": "195", "unit": "mg/dL", "status": "normal"},
        {"name": "LDL", "value": "115", "unit": "mg/dL", "status": "normal"},
        {"name": "HDL", "value": "50", "unit": "mg/dL", "status": "normal"},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _banner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.green.shade50]),
        border: Border.all(color: Colors.blue.withOpacity(0.18)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome back, John', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("Here's your health overview. Stay on top of your medical records.", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _metricsGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final columns = width < 480 ? 1 : (width < 900 ? 2 : 3);
      // On mobile we want taller cards so set childAspectRatio lower (height larger)
      final childAspectRatio = width < 480 ? 3.4 : (width < 900 ? 2.8 : 3.5);

      return GridView.count(
        crossAxisCount: columns,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
        children: const [
          HealthMetricsCard(title: 'Height', value: '5\'11"', unit: '(180 cm)', icon: '📏'),
          HealthMetricsCard(title: 'Weight', value: '180 lbs', unit: '(82 kg)', icon: '⚖️'),
          HealthMetricsCard(title: 'Active Records', value: '12', unit: 'records', icon: '📋'),
        ],
      );
    });
  }

  Widget _prescriptionsView() {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final columns = width < 480 ? 1 : 2;
      final aspect = width < 480 ? 2.6 : 1.6;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: prescriptions.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: aspect,
        ),
        itemBuilder: (context, index) {
          final p = prescriptions[index];
          return PrescriptionCard(
            medication: p['medication'] as String,
            dosage: p['dosage'] as String,
            frequency: p['frequency'] as String,
            startDate: p['startDate'] as String,
            endDate: p['endDate'] as String,
            doctor: p['doctor'] as String,
          );
        },
      );
    });
  }

  Widget _labReportsView() {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final columns = width < 480 ? 1 : 2;
      final aspect = width < 480 ? 1.0 : 1.3;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bloodTests.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: aspect,
        ),
        itemBuilder: (context, index) {
          final b = bloodTests[index];
          return BloodTestCard(
            testName: b['testName'] as String,
            date: b['date'] as String,
            lab: b['lab'] as String,
            results: (b['results'] as List).map<Map<String, String>>((e) => {
              'name': e['name'] as String,
              'value': e['value'] as String,
              'unit': e['unit'] as String,
              'status': e['status'] as String,
            }).toList(),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // reserve space so bottom nav won't overlap
    final bottomReserved = mq.padding.bottom + 80.0;
    // compute a safe tab view height but avoid forcing a large fixed height
    final maxHeight = mq.size.height - kToolbarHeight - mq.padding.top - 240.0;
    final tabHeight = maxHeight.clamp(300.0, 1200.0);

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.blue.shade200, borderRadius: BorderRadius.circular(8)), child: const Center(child: Text('H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 12),
          const Text('HealthHub'),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, bottomReserved),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _banner(),
            const SizedBox(height: 16),
            _metricsGrid(),
            const SizedBox(height: 16),
            // Tabs
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black54,
                tabs: const [Tab(text: 'Prescriptions'), Tab(text: 'Lab Reports')],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: tabHeight,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // each tab content is scrollable (its GridView is shrinkWrap)
                  SingleChildScrollView(child: Padding(padding: const EdgeInsets.only(bottom: 8.0), child: _prescriptionsView())),
                  SingleChildScrollView(child: Padding(padding: const EdgeInsets.only(bottom: 8.0), child: _labReportsView())),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
