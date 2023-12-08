import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Data/fetchdata.dart';
import 'package:flutter_application_1/Game_interfaces/UI_Score_Page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

//Quiz Page for playing quiz where different actions like checking answer, changing state occurs.
class QuizMind extends StatefulWidget {
  const QuizMind({Key? key}) : super(key: key);

  @override
  State<QuizMind> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizMind> {
  int index = 0;
  int Score = 0;
  int ansIndex = 1;
  int ques = 0;
  int correctAns = 0;
  int incorrectAns = 0;
  bool isTap1 = false;
  bool isTap2 = false;
  bool isTap3 = false;
  bool isTap4 = false;

  double timerProgress = 1.0;
  late Timer timer;
  int totalQuestions = 10;
  int totalTimeInSeconds = 350;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const int timerUpdateInterval = 1;

    timer = Timer.periodic(Duration(seconds: timerUpdateInterval), (timer) {
      setState(() {
        timerProgress -= (timerUpdateInterval / totalTimeInSeconds);

        if (timerProgress <= 0) {
          timer.cancel();
          navigateToScorePage();
        }
      });
    });

    Future.delayed(Duration(seconds: totalTimeInSeconds), () {
      timer.cancel();
      if (ques < totalQuestions) {
        nextQuestion();
      } else {
        updateScore(); // Update the score on the last question
        navigateToScorePage();
      }
    });
  }

  void nextQuestion() {
    setState(() {
      index = index + 2;
      ques++;
      isTap2 ? Score = Score + 10 : null;
      isTap2 ? correctAns++ : incorrectAns++;
      isTap1 = false;
      isTap2 = false;
      isTap3 = false;
      isTap4 = false;
      timerProgress = 1.0;
      startTimer(); // Restart the timer for the next question
    });
  }

  void updateScore() {
    // Update the score one more time for the last question
    isTap2 ? Score = Score + 10 : null;
    isTap2 ? correctAns++ : incorrectAns++;
  }

  void navigateToScorePage() {
    Get.to(() => ScorePage(
          correctAnswer: correctAns,
          incorrectAnswer: incorrectAns,
          score: Score,
        ));
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Color(0XFF5691A4),
        title: Text('QuizMasterMind'),
        toolbarHeight: 70,
      ),
      body: Consumer(builder: (context, ref, child) {
        final question = ref.watch(quiz);

        if (question.value != null) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0XFF5691A4)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0XFF1C2120),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFF093028),
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Total Score:${Score}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.grey, // customize the color
                        thickness: 2.0, // can customize the thickness
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.5), // Shadow color and opacity
                            spreadRadius: 1.0, // Spread radius
                            blurRadius: 10.0, // Blur radius
                            offset: Offset(0, 3), // Offset of the shadow
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Timer:',
                      style: TextStyle(
                          color: Colors.white, // Change text color
                          fontSize: 15.0, // Change text size
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                        value: timerProgress,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.indigo),
                        backgroundColor: Colors.grey,
                        minHeight: 25,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Challenge: $ques/10",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Pick the correct option.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey.shade500,
                      height: 220,
                      width: double.infinity,
                      child: Image.network(
                        "${question.value![index]}",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: isTap1 ? Colors.grey : Color(0XFF5691A4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${question.value![index + 1]}.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isTap1 = !isTap1;

                              isTap2 = false;
                              isTap3 = false;
                              isTap4 = false;
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: isTap2 ? Colors.grey : Color(0XFF5691A4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${question.value![ansIndex] + 1}.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isTap2 = !isTap2;
                              isTap3 = false;
                              isTap1 = false;
                              isTap4 = false;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: isTap3 ? Colors.grey : Color(0XFF5691A4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${question.value![ansIndex] + 2}.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isTap3 = !isTap3;
                              isTap1 = false;
                              isTap2 = false;
                              isTap4 = false;
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: isTap4 ? Colors.grey : Color(0XFF5691A4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${question.value![ansIndex] + 3}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isTap4 = !isTap4;

                              isTap1 = false;
                              isTap2 = false;
                              isTap3 = false;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          index = index + 2;
                          ques++;

                          if (isTap4 || isTap1) {
                            Score = Score + 10;
                            correctAns++;
                          } else {
                            incorrectAns++;
                          }

                          isTap1 = false;
                          isTap2 = false;
                          isTap3 = false;
                          isTap4 = false;
                        });

                        if (ques >= totalQuestions) {
                          // If 10 questions are completed, navigate to the score page
                          navigateToScorePage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Continue"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Correct Choices:$correctAns ",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Incorrect Choices:$incorrectAns ",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Visual timer
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
