import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(
                maxWidth: 364
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Row(
                children: [
                Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}