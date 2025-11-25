import 'package:flutter/material.dart';
import 'screens/home_shell.dart';
import 'screens/lab_reports_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Keep your existing HomeShell as the app's home:
      home: const HomeShell(),

      // Add routes so you can navigate with names:
      routes: {
        '/lab-reports': (context) => const LabReportsScreen(),
        // add other named routes here if needed
      },
    );
  }
}
