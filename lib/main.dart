import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Speed Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TypingTestPage(),
    );
  }
}

class TypingTestPage extends StatefulWidget {
  const TypingTestPage({super.key});

  @override
  State<TypingTestPage> createState() => _TypingTestPageState();
}

class _TypingTestPageState extends State<TypingTestPage> {
  final TextEditingController _textController = TextEditingController();
  final String _targetText = "The quick brown fox jumps over the lazy dog";
  String _typedText = "";
  int _startTime = 0;
  int _elapsedTime = 0;
  bool _isTyping = false;
  Timer? _timer;
  int _correctChars = 0;
  int _totalChars = 0;
  int _errors = 0;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    if (!_isTyping && _textController.text.isNotEmpty) {
      _startTest();
    }
    setState(() {
      _typedText = _textController.text;
      _calculateAccuracy();
    });
  }

  void _calculateAccuracy() {
    _totalChars = _typedText.length;
    _correctChars = 0;
    _errors = 0;

    for (int i = 0; i < _typedText.length; i++) {
      if (i < _targetText.length) {
        if (_typedText[i] == _targetText[i]) {
          _correctChars++;
        } else {
          _errors++;
        }
      } else {
        _errors++;
      }
    }
  }

  double get _accuracy {
    if (_totalChars == 0) return 100.0;
    return (_correctChars / _totalChars) * 100;
  }

  void _startTest() {
    setState(() {
      _isTyping = true;
      _startTime = DateTime.now().millisecondsSinceEpoch;
      _elapsedTime = 0;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().millisecondsSinceEpoch - _startTime;
      });
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int get _wordsTyped {
    if (_typedText.trim().isEmpty) return 0;
    return _typedText.trim().split(RegExp(r'\s+')).length;
  }

  double get _wpm {
    if (_elapsedTime == 0) return 0.0;
    double minutes = _elapsedTime / 60000.0;
    return (_wordsTyped / minutes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Speed Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                _targetText,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _textController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Start typing...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

