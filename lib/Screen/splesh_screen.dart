import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notepad/Screen/HomePage.dart';

import 'AuthScreen/LogInScreen.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    gotoLogInScreen();
    super.initState();
  }
  User? user = FirebaseAuth.instance.currentUser;
  void gotoLogInScreen() {
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => user != null? HomePage():LogInScreen(showLoginPage: () {})),(route) => false,));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('Assetes/animation/splesh.json'),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('WELCOME TO ',
                    textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                TypewriterAnimatedText(
                    'NOTE PAD', textStyle: TextStyle(fontSize: 26)),
                TypewriterAnimatedText('APPLICATION',),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
