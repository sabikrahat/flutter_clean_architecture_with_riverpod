import 'package:flutter/material.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const Center(
        child: Text('Complete Profile'),
      ),
    );
  }
}
