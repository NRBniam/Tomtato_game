import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  ScorePage({
    required this.score,
    required this.correctAnswer,
    required this.incorrectAnswer,
  });

  final int score;
  final int correctAnswer;
  final int incorrectAnswer;

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage>
    with SingleTickerProviderStateMixin {
  // Animation controller to manage animations
  late AnimationController _controller;

  // Opacity animation for fading in the content
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Create a fade-in animation using the controller
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the fade-in animation when the widget is first built
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5691A4),
        title: const Text("QuizMasterMind"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA06FA6), Color(0xFF3690C0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Star icon for decoration
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 80,
                ),
                SizedBox(height: 20),
                // Congratulations text
                Text(
                  "Congratulations!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                // Quiz score text
                Text(
                  "Your Quiz Score:",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                // Display the user's score
                Text(
                  "${widget.score} Points",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                // Display the number of correct answers
                Text(
                  "Correct Answers: ${widget.correctAnswer}",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                // Display the number of incorrect answers
                Text(
                  "Incorrect Answers: ${widget.incorrectAnswer}",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }
}
