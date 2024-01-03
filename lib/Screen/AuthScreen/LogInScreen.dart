import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/Screen/AuthScreen/forgetpassword.dart';
import 'package:notepad/Screen/HomePage.dart';
import 'package:notepad/Screen/AuthScreen/signUp.dart';

class LogInScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const LogInScreen({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  LogIn() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => HomePage()),(route) => false, );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for the email')));
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Wrong password')));
      }
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SingleChildScrollView(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Get Started With',
                        textStyle:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: TextFormField(
                validator: (String? value){
                  if(value?.isEmpty ?? true){
                    return 'Enter Your Email';
                  }
                },
                controller: _emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: TextFormField(
                validator: (String? value){
                  if(value?.isEmpty ?? true){
                    return 'Enter your password!';
                  }
                },
                controller: _passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if(!_formkey.currentState!.validate()){
                      return ;
                    }
                    LogIn();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400),
                  child: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 30,
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPasswordPage()));
              },
              child: const Text(
                'Forget password ?',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't Have Account! ",
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp(singupPage: () {  },)));
                    },
                    child: const Text('Sing up'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
