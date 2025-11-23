import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const TypingSpeedTestApp());
}

class TypingSpeedTestApp extends StatefulWidget {
  const TypingSpeedTestApp({super.key});
  @override
  State<TypingSpeedTestApp> createState() => _TypingSpeedTestAppState();
}

class _TypingSpeedTestAppState extends State<TypingSpeedTestApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Speed Test',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode, // Uses the current mode.
      home: TypingTestPage(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

enum Difficulty { easy, medium, hard }

class TypingTestPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  const TypingTestPage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  _TypingTestPageState createState() => _TypingTestPageState();
}

class _TypingTestPageState extends State<TypingTestPage> {
  final Map<Difficulty, List<String>> _sentences = {
    Difficulty.easy: [
      "The quick brown fox jumps over the lazy dog",
      "Flutter makes beautiful apps for mobile",
      "Typing fast is fun and useful",
      "Practice daily to improve your speed",
      "Keep your hands relaxed and fingers ready",
      "The cat sat on the warm sunny window sill",
      "Birds sing sweet songs in the early morning",
      "She likes to read books under the big tree",
      "The dog loves to play fetch in the park",
      "He enjoys walking by the calm river at sunset",
      "Apples and oranges make a healthy snack",
      "Children laugh and run around the playground",
      "The sun shines brightly on a clear day",
      "Flowers bloom beautifully in the springtime",
      "A gentle breeze cools the warm summer air",
    ],
    Difficulty.medium: [
      "Typing tests improve speed and accuracy with practice regularly",
      "Developers often use Flutter for cross platform apps",
      "Longer sentences help in building muscle memory",
      "Accuracy is as important as building speed",
      "Consistent practice leads to noticeable improvements",
      "Improving typing speed requires consistent daily practice and focus",
      "Technology advances rapidly, changing how we communicate and work",
      "Learning new skills can open doors to many exciting opportunities",
      "Creative thinking helps solve complex problems effectively and efficiently",
      "Balancing work and rest is essential for maintaining productivity",
      "Time management plays a crucial role in achieving your goals",
      "Reading challenging texts builds vocabulary and comprehension skills",
      "Maintaining good posture prevents fatigue during long typing sessions",
      "Asking for feedback can provide valuable insights to improve",
      "Teamwork involves communication, collaboration, and mutual respect",
    ],
    Difficulty.hard: [
      "Unmanageable, problematical, troublesome, perplexing, and formidable challenges await skilled typists",
      "Proficiency demands discipline, patience, and constant repetition to master",
      "Technical jargon and complex sentences push your limits",
      "Rapid shifts in case and punctuation test attention and skill",
      "Sustained focus is essential for peak typing performance",
      "Seemingly insignificant errors can dramatically affect one's overall accuracy score",
      "A comprehensive understanding of keyboard layouts facilitates efficiency",
      "Peripheral vision and ergonomic hand placement minimize fatigue and maximize results",
      "Ambidextrous typists effortlessly alternate between keys for enhanced performance",
      "Analytical skills are honed through persistent, mindful engagement in challenging content",
    ],
  };

  Difficulty _selectedDifficulty = Difficulty.easy;
  late String _testText;
  final TextEditingController _controller = TextEditingController();

  int _timerSeconds = 60;
  Timer? _timer;
  bool _isRunning = false;

  int _correctChars = 0;
  int _totalTyped = 0;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadNewSentence();
  }

  void _loadNewSentence() {
    var list = _sentences[_selectedDifficulty]!;
    setState(() {
      _testText = list[_random.nextInt(list.length)];
      _controller.clear();
      _correctChars = 0;
      _totalTyped = 0;
    });
  }

  void _startTest() {
    _loadNewSentence();
    setState(() {
      _timerSeconds = 60;
      _correctChars = 0;
      _totalTyped = 0;
      _isRunning = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds == 0) {
        _stopTest();
      } else {
        setState(() {
          _timerSeconds--;
        });
      }
    });
  }

  void _stopTest() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _onTextChanged(String value) {
    if (!_isRunning) return;

    int correct = 0;
    for (int i = 0; i < value.length; i++) {
      if (i < _testText.length && value[i] == _testText[i]) {
        correct++;
      }
    }

    setState(() {
      _totalTyped = value.length;
      _correctChars = correct;

      if (value == _testText) {
        _stopTest();
      }
    });
  }

  double get _accuracy {
    if (_totalTyped == 0) return 0;
    return (_correctChars / _totalTyped) * 100;
  }

  double get _wpm {
    if (!_isRunning && _timerSeconds == 60) return 0;
    final int elapsed = 60 - _timerSeconds;
    if (elapsed == 0) return 0;
    final words = _correctChars / 5;
    return words / (elapsed / 60);
  }

  Color _getCharColor(int index) {
    if (index >= _controller.text.length) return Colors.grey;
    if (index >= _testText.length) return Colors.red.shade300;
    return _controller.text[index] == _testText[index]
        ? Colors.green
        : Colors.red.shade700;
  }

  Widget _buildTestText() {
    List<TextSpan> spans = [];
    for (int i = 0; i < _testText.length; i++) {
      spans.add(TextSpan(
        text: _testText[i],
        style: TextStyle(
          color: _getCharColor(i),
          backgroundColor: (i == _controller.text.length && _isRunning)
              ? Colors.blue.shade100
              : Colors.transparent,
          fontWeight: (i == _controller.text.length && _isRunning)
              ? FontWeight.bold
              : null,
          fontSize: 24,
        ),
      ));
    }
    return RichText(text: TextSpan(children: spans));
  }

  Widget _buildDifficultySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text('Easy'),
          selected: _selectedDifficulty == Difficulty.easy,
          onSelected: (selected) {
            if (selected && !_isRunning) {
              setState(() {
                _selectedDifficulty = Difficulty.easy;
                _loadNewSentence();
              });
            }
          },
          selectedColor: Colors.indigo.shade300,
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text('Medium'),
          selected: _selectedDifficulty == Difficulty.medium,
          onSelected: (selected) {
            if (selected && !_isRunning) {
              setState(() {
                _selectedDifficulty = Difficulty.medium;
                _loadNewSentence();
              });
            }
          },
          selectedColor: Colors.indigo.shade300,
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text('Hard'),
          selected: _selectedDifficulty == Difficulty.hard,
          onSelected: (selected) {
            if (selected && !_isRunning) {
              setState(() {
                _selectedDifficulty = Difficulty.hard;
                _loadNewSentence();
              });
            }
          },
          selectedColor: Colors.indigo.shade300,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Speed Test'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: widget.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode",
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDifficultySelector(),
            const SizedBox(height: 20),
            _buildTestText(),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              enabled: _isRunning,
              autofocus: _isRunning,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2)),
                hintText: 'Start typing here...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
                ),
              ),
              onChanged: _onTextChanged,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time: $_timerSeconds s', style: const TextStyle(fontSize: 18)),
                Text('WPM: ${_wpm.toStringAsFixed(1)}', style: const TextStyle(fontSize: 18)),
                Text('Accuracy: ${_accuracy.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _isRunning ? _stopTest : _startTest,
                child: Text(_isRunning ? 'Finish Test' : 'Start Test'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  minimumSize: const Size(150, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            if (!_isRunning && _totalTyped > 0)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    'Test Complete!\nWPM: ${_wpm.toStringAsFixed(1)}\nAccuracy: ${_accuracy.toStringAsFixed(1)}%',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
