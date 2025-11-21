import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Typing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TypingHomePage(),
    );
  }
}

class TypingHomePage extends StatefulWidget {
  const TypingHomePage({super.key});

  @override
  State<TypingHomePage> createState() => _TypingHomePageState();
}

class _TypingHomePageState extends State<TypingHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Keyboard Typing'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Keyboard Typing!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Start your typing practice',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

