import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajuda')),
      body: const Center(
        child: Text('Página de ajuda', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
