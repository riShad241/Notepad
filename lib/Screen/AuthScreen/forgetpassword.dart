import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> passwordReset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check your email')));
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter your register email')));
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget password page'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Enter your register email',style: TextStyle(fontSize: 40),)),

          const SizedBox(height: 16,),
          /// Email textfield in here..
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Email'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16,),
          ElevatedButton(onPressed: (){
            passwordReset();
          }, child: Text('Reset Password',style: TextStyle(fontSize: 22),)),
        ],
      ),
    );
  }
}