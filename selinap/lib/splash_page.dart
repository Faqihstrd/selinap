import 'package:flutter/material.dart';
import 'package:selinap/database/user_local.dart';
import 'package:selinap/login/login.dart';
import 'package:selinap/tema_app/fitness_app_home_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final local = UserLocal();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          // builder: (context) => FitnessAppHomeScreen(),
          builder: (context) =>
              local.isLogin ? const FitnessAppHomeScreen() : const Login(),
        ),
        (r) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 300,
          height: 400,
        ),
      ),
    );
  }
}
