import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/Screen/AuthScreen/LogInScreen.dart';
import 'package:notepad/Screen/HomePage.dart';

class SignUp extends StatefulWidget {
  final VoidCallback singupPage;

  const SignUp({Key? key, required this.singupPage}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void dispose() {
    _EmailController.dispose();
    _FirstNameController.dispose();
    _LastNameController.dispose();
    _MobileController.dispose();
    _PasswordController.dispose();
    super.dispose();
  }

  TextEditingController _EmailController = TextEditingController();
  TextEditingController _FirstNameController = TextEditingController();
  TextEditingController _LastNameController = TextEditingController();
  TextEditingController _MobileController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  TextEditingController _ConfromPasswordController = TextEditingController();

  Future<void> userSignUp() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      if (confirmpass()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _EmailController.text.trim(),
            password: _PasswordController.text.trim());
        addUserDetails(
          _EmailController.text.trim(),
          _FirstNameController.text.trim(),
          _LastNameController.text.trim(),
          _MobileController.text.trim(),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        if (mounted) {
          setState(() {
            _EmailController.clear();
            _PasswordController.clear();
            _ConfromPasswordController.clear();
          });
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Email already register')));
    }
  }

  Future addUserDetails(
      String email, String firstname, String lastname, String mobile) async {
    await FirebaseFirestore.instance.collection('User').doc(email).set({
      'email': email,
      'first name': firstname,
      'last name': lastname,
      'mobile': mobile,
    });
  }

  bool confirmpass() {
    if (_PasswordController.text.trim() ==
        _ConfromPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Join With Us ',
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    controller: _EmailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    controller: _FirstNameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'First name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    controller: _LastNameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Last Name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    controller: _MobileController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Mobile',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    controller: _PasswordController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    controller: _ConfromPasswordController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
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
                        userSignUp();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade400),
                      child: const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: 30,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      " Have  Account ! ",
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen(
                                        showLoginPage: () {},
                                      )));
                        },
                        child: const Text('Log in'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
