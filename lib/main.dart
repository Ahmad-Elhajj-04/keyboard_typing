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
      "Early in the morning, the family packed their bags and drove to the quiet park where everyone enjoyed playing games, eating sandwiches, and watching the ducks swim on the smooth blue pond.",
      "Every student in the class worked hard on their science project, using paper, glue, and colorful markers to build a model that was both creative and easy to understand.",
      "After finishing his homework, Brian cleaned his room, fed his pet fish, and then read a new storybook that his mother bought from the big bookstore near their home.",
      "During the summer holidays, children love to ride their bikes around the neighborhood, stopping to visit friends, eat ice cream, and pick fresh fruit from backyard trees.",
      "Sarah and her brother spent the rainy afternoon inside, building a tall fort with blankets and chairs, telling funny stories, and drawing pictures of their favorite animals.",
      "Once a week, the teacher took the class to the school garden so they could learn about plants, water the flowers, and watch the tiny bugs crawling around in the fresh soil.",
      "Each morning, the old man walks to the market, buys bread and cheese, greets his neighbors with a friendly smile, and returns home to read the daily newspaper by the sunny window.",
      "The friendly dog likes to run in the field, catch a red ball, roll in the grass, and rest under the big tree until his owner calls him home for dinner.",
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
      "While the children explored the forest behind their school, they discovered several unusual plants and insects, carefully recording their observations in small notebooks to share with their teacher the next day.",
          "The family’s weekend trip to the crowded city included sightseeing at museums, trying new foods at busy restaurants, and watching an exciting parade with bright costumes and cheerful music.",
          "Although rain poured throughout the afternoon, the friends stayed indoors playing board games, baking chocolate chip cookies, and planning their next outdoor adventure when the sun returned.",
          "Before the big test, Maria reviewed each chapter, practiced answering difficult questions with her study group, and made sure she got enough sleep to feel ready and confident in the morning.",
          "Tom and his neighbors joined together to clean up the local park, collecting trash, planting fresh flowers by the playground, and setting up benches for families to enjoy the peaceful atmosphere.",
          "Every spring, the library hosts a reading contest where students pick long books, track their progress on colorful charts, and compete for prizes that encourage everyone to read more.",
          "During a long road trip, the group played word games to pass the time, shared interesting stories about their favorite places, and took turns choosing music that everyone could enjoy.",
          "After attending the science fair, the students discussed their favorite experiments, learned about simple machines and renewable energy, and drew posters to present what they discovered to their classmates.",
    ],
    Difficulty.hard: [
      "Unmanageable, problematical, troublesome, perplexing, and formidable challenges await skilled typists",
      "Proficiency demands discipline, patience, and constant repetition to master",
      "Seemingly insignificant errors can dramatically affect one's overall accuracy score",
      "A comprehensive understanding of keyboard layouts facilitates efficiency",
      "Peripheral vision and ergonomic hand placement minimize fatigue and maximize results",
      "Ambidextrous typists effortlessly alternate between keys for enhanced performance",
      "Analytical skills are honed through persistent, mindful engagement in challenging content",
      "With remarkable composure and steadfast determination, the researcher meticulously documented every variable and anomaly throughout the lengthy experiment, ensuring the data would withstand intense scrutiny by skeptical peers.",
          "Adapting to rapidly changing technologies and unpredictable market trends, the company’s innovation team devised comprehensive strategies involving cross-disciplinary collaboration to secure a sustainable competitive advantage.",
          "As the sun dipped beneath the horizon, casting elongated shadows across the tranquil landscape, the hikers reflected on the profound impact of nature’s beauty on their perspective, ambitions, and sense of well-being.",
          "To cultivate an atmosphere conducive to meaningful learning, educators must balance clear instruction with moments for independent critical thinking, fostering intellectual curiosity and resilience amid academic challenges.",
          "Though the committee was initially divided on how to allocate resources, persuasive arguments highlighting long-term global benefits ultimately swayed their decision toward supporting groundbreaking renewable energy initiatives.",
          "Having reviewed the multifaceted proposal in great detail, the panel raised questions regarding logistical feasibility, financial investment, and projected outcomes before finally reaching a consensus.",
          "Recognizing the potential for miscommunication in complex, multicultural teams, the manager emphasized transparency and empathy as vital components of effective leadership and optimal group performance.",
          "While striving for excellence over the course of their careers, professionals often encounter setbacks that test their adaptability, perseverance, and willingness to continuously refine their skills and approaches.",
    ],
  };

  Difficulty _selectedDifficulty = Difficulty.easy;
  late String _testText;
  final TextEditingController _controller = TextEditingController();

  int _timerSeconds = 360;
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
      _timerSeconds = 360;
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
        _loadNewSentence();
        _controller.clear();
      }
    });
  }

  double get _accuracy {
    if (_totalTyped == 0) return 0;
    return (_correctChars / _totalTyped) * 100;
  }

  double get _wpm {
    if (!_isRunning && _timerSeconds == 360) return 0;
    final int elapsed = 360 - _timerSeconds;
    if (elapsed == 0) return 0;
    final words = _correctChars / 5;
    return words / (elapsed / 360);
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
