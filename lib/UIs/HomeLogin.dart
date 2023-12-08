import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/firebase_authentication.dart';
import 'package:flutter_application_1/Data/fetchdata.dart';
import 'package:flutter_application_1/Game_interfaces/Manual.dart';
import 'package:flutter_application_1/Game_interfaces/quizMindUI.dart';
import 'package:flutter_application_1/UIs/UIregister.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5691A4),
        title: Center(
          child: ContinuousAnimatedText(),
        ),
        toolbarHeight: 160,
        elevation: 50,
      ),
      body: Container(
        color: Color(0XFF5691A4),
        child: Consumer(
          builder: ((context, ref, child) {
            return FutureBuilder(
              // Delay execution of the UI code for 3 seconds
              future: Future.delayed(Duration(seconds: 3)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Form(
                    key: _form,
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          color: Colors.red[390],
                        ),
                        Center(
                          child: Container(
                            height: 620,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(170.0),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                children: [
                                  const SizedBox(height: 30),
                                  const Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 38,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text('Sign-in to Continue.'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 55),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            SizedBox(width: 10),
                                            Text(
                                              "Username or Email",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          validator: ((value) {
                                            if (value!.isEmpty) {
                                              return "Please Enter Email";
                                            } else {
                                              return null;
                                            }
                                          }),
                                          controller: usernameController,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter your Username/Gmail",
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: Icon(
                                                Icons.supervised_user_circle),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: const [
                                            SizedBox(width: 10),
                                            Text(
                                              "Password",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          validator: ((value) {
                                            if (value!.isEmpty) {
                                              return "Password";
                                            } else {
                                              return null;
                                            }
                                          }),
                                          obscureText: !isTap,
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            hintText: "Enter the password.",
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: InkWell(
                                              child: isTap
                                                  ? Icon(Icons.visibility)
                                                  : Icon(Icons.visibility_off),
                                              onTap: (() {
                                                setState(() {
                                                  isTap = !isTap;
                                                });
                                              }),
                                            ),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0XFF1C2120),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Sign In",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ManualScreen(),
                                              ),
                                            );
                                          },

                                          /*() async {
                                            _form.currentState!.save();
                                            if (_form.currentState!
                                                .validate()) {
                                              final response = await ref
                                                  .read(authprovider)
                                                  .userlogin(
                                                    usernameController.text
                                                        .trim(),
                                                    passwordController.text
                                                        .trim(),
                                                  );

                                              if (response != "Successful") {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    duration:
                                                        Duration(seconds: 5),
                                                    content: Text('$response'),
                                                  ),
                                                );
                                              } else if (response ==
                                                  "Initializing") {
                                                Get.defaultDialog(
                                                  middleText: "Please Wait...",
                                                );
                                              } else {
                                                Get.to(() => ManualScreen());
                                              }
                                            } else {
                                              return null;
                                            }
                                          },*/
                                        ),
                                        Center(
                                          child: TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              "Forgot Password",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, right: 20),
                                                child: MaterialButton(
                                                  color: Colors.teal[100],
                                                  elevation: 10,
                                                  onPressed: () {
                                                    SignUp();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              'https://icon2.cleanpng.com/20171220/dxq/google-png-5a3aafee6ff5c8.9595681415137955664586.jpg',
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 1),
                                                      Text(
                                                          "  Sign In with Google"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.to(() => SignUp());
                                                },
                                                child: const Text("Sign Up"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ManualScreen(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0XFF1C2120),
                                              fixedSize: Size(150, 50),
                                            ),
                                            child: Text('Play as a guest'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Display a loading indicator while waiting for the delay
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
        ),
      ),
    );
  }
}

class ContinuousAnimatedText extends StatefulWidget {
  @override
  _ContinuousAnimatedTextState createState() => _ContinuousAnimatedTextState();
}

class _ContinuousAnimatedTextState extends State<ContinuousAnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animation after a delay of 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Text(
            "QuizMasterMind",
            style: TextStyle(
              fontSize: 35.0,
              fontFamily: 'YourCustomFont',
              color: Color.lerp(Colors.white, Colors.red, _animation.value),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
