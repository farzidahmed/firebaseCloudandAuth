import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing_app/fcm_notification_manager.dart';
import 'package:firebase_testing_app/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Future<void> login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: 'rimonrajgg670@gmail.com', password: '12345678')
        .then((value) {
      print("login success");
    }).onError((error, StackTrace) {
      print("failed${error.toString()}");
    });
     await FcmNotificationManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          Get.to(const Home());
          login();
          print("login hoiche");
        },
            child:Text('login'),
      ),
      )
    );
  }
}
