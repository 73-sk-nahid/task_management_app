import 'package:flutter/material.dart';
import 'package:task_management_app/style/style.dart';

import '../api/api_client.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Map<String, String> FormValues = {
    "email": "",
    "password": "",
  };

  ItemOnChange(MapKey, TextValue) {
    setState(() {
      FormValues.update(MapKey, (value) => TextValue);
    });
  }

  FormOnSubmit() async{
    // Email validation with a regex
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    if(FormValues['email']!.isEmpty){
      ErrorToast("Please Enter an email");
    }
    else if(!emailRegExp.hasMatch(FormValues['email']!)){
      ErrorToast("Please enter valid email");
    }
    else if(FormValues['password']!.isEmpty){
      ErrorToast("Please enter password");
    }
    else {
      setState(() {_isLoading=true;});
      bool res=await LoginRequest(FormValues);
      if(res==true){
        // SuccessToast("Hurrah! Your Login is in processing....");
        Navigator.pushNamedAndRemoveUntil(context, "/registration", (route) => false);
      }
      else{
        setState(() {_isLoading=false;});
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: _isLoading
                  ? (Center(
                      child: CircularProgressIndicator(),
                    ))
                  : Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Get Started With",
                              style: Head1Text(colorBlack),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: AppInputDecoration("Email"),
                            onChanged: (TextValue) {
                              ItemOnChange("email", TextValue);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: AppInputDecoration("Password"),
                            onChanged: (TextValue) {
                              ItemOnChange("password", TextValue);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FormOnSubmit();
                            },
                            child: SuccessButtonChild("Log In"),
                            style: AppButtonStyle(),
                          ),
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
