import 'package:flutter/material.dart';
import 'package:task_management_app/home_screen.dart';
import 'package:task_management_app/screens/email_verify_screen.dart';
import 'package:task_management_app/screens/login_screen.dart';
import 'package:task_management_app/screens/pin_verify_screen.dart';
import 'package:task_management_app/screens/registration_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_management_app/screens/set_password_screen.dart';
import 'package:task_management_app/utility/utility.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String? token = await GetUserDetails("token");
  // if(token == null) {
  //   runApp(MyApp("/login"));
  // }
  // else {
  //   runApp(MyApp("/"));
  // }
  runApp(MyApp("/mailVerify"));
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
        "/":(context)=> HomeScreen(),
        "/login":(context) => LoginScreen(),
        "/registration":(context) => RegistrationScreen(),
        "/mailVerify" : (context) => EmailVerifyScreen(),
        "/pinVerify" : (context) => PinVerifyScreen(),
        "'setPassword" : (context) => SetPasswordScreen(),
      },
    );
  }
}

