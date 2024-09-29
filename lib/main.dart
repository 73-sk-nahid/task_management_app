import 'package:flutter/material.dart';
import 'package:task_management_app/screens/login_screen.dart';
import 'package:task_management_app/screens/email_verify_screen.dart';
import 'package:task_management_app/screens/pin_verify_screen.dart';
import 'package:task_management_app/screens/registration_screen.dart';
import 'package:task_management_app/screens/set_password_screen.dart';
import 'package:task_management_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp("/login"));
}

class MyApp extends StatelessWidget {
  final String FirstRoute;
  MyApp(this.FirstRoute);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      initialRoute: FirstRoute,
      routes: {
        "/login":(context) => LoginScreen(),
        "/registration":(context) => RegistrationScreen(),
      },
    );
  }
}

