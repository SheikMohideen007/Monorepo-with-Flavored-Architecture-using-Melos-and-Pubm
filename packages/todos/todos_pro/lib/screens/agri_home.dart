import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AgriHome extends StatefulWidget {
  const AgriHome({super.key});

  @override
  State<AgriHome> createState() => _AgriHomeState();
}

class _AgriHomeState extends State<AgriHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agri Loan Home')),
      body: const Center(
        child: Text(
          'Welcome to the Agri Loan App!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
