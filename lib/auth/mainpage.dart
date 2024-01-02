
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screen/splesh_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return SpleshScreen();
          }else{
            return SpleshScreen();
          }
        },
      ),
    );
  }
}
