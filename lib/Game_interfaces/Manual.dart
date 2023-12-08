import 'package:flutter/material.dart';
import 'package:flutter_application_1/Game_interfaces/quizMindUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManualScreen(),
    );
  }
}

class ManualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Game Manual'),
        backgroundColor: Color(0XFF5691A4),
        toolbarHeight: 65,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ManualCard(
                title: 'Welcome to the Math Game!',
                content: 'This game is designed to test your math skills. '
                    'You will be presented with a series of 10 math questions, and '
                    'you need to choose the correct answer within a 10-second time limit.',
              ),
              ManualCard(
                title: 'How to Play',
                content: '1. A question will be displayed on the screen.\n'
                    '2. You have 10 seconds to choose the correct answer.\n'
                    '3. Tap on the answer button to make your selection.\n'
                    '4. After 10 questions, your final score will be displayed.',
              ),
              ManualCard(
                title: 'Scoring',
                content: 'Each correct answer earns you 10 points. '
                    'Your total score will be displayed throughout the game and also at the end.',
              ),
              ManualCard(
                title: 'Timer',
                content: 'Make sure to answer within 10 second to earn points.',
              ),
              ManualCard(
                title: 'Example Question',
                content: 'Example: What is 2 + 2?\n'
                    'A) 3\n'
                    'B) 4\n'
                    'C) 5\n'
                    'D) 8\n'
                    'Tap on the correct option to submit your answer.',
              ),
              ManualCard(
                title: 'Challenge Yourself and Enjoy the Game!',
                content:
                    'After completing the 10 questions, your final score will be shown. '
                    'Remember, the more you play, the better you get. Enjoy the game!',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the other page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizMind()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0XFF1C2120),
                  fixedSize: Size(150, 50),
                ),
                child: Text('Play Game'),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ManualCard extends StatelessWidget {
  final String title;
  final String content;

  ManualCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}
