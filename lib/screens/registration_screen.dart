import 'package:flutter/material.dart';
import 'package:task_management_app/style/style.dart';

import '../api/api_client.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Map<String, String> FormValues = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "mobile": "",
    "password": "",
    "cpassword": ""
  };

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isCPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
  void toggleCPasswordVisibility() {
    setState(() {
      _isCPasswordVisible = !_isCPasswordVisible;
    });
  }

  InputOnChange(MapKey, TextValue) {
    setState(() {
      FormValues.update(MapKey, (value) => TextValue);
    });
  }

  FormOnSubmit() async{

    // Email validation with a regex
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    // Password validation pattern: Minimum 8 characters, at least one uppercase letter, one lowercase letter, one number, and one special character
    bool hasUppercase = FormValues['password']!.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = FormValues['password']!.contains(RegExp(r'[a-z]'));
    bool hasDigits = FormValues['password']!.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = FormValues['password']!.contains(RegExp(r'[!@#\$&*~]'));
    bool hasMinLength = FormValues['password']!.length >= 8;

    if (FormValues['email']!.isEmpty || !emailRegExp.hasMatch(FormValues['email']!)) {
      ErrorToast('Please enter a valid email address!');
    } else if (FormValues['firstName']!.trim().isEmpty) {
      ErrorToast('First Name is required!');
    } else if (FormValues['lastName']!.trim().isEmpty) {
      ErrorToast('Last Name is required!');
    } else if (FormValues['mobile']!.isEmpty || FormValues['mobile']!.length < 10) {
      ErrorToast('Please enter a valid mobile number (at least 10 digits)!');
    } else if (FormValues['password']!.isEmpty) {
      ErrorToast('Password is required!');
    } else if (!hasMinLength) {
      ErrorToast('Password must be at least 8 characters long!');
    } else if (!hasUppercase) {
      ErrorToast('Password must contain at least one uppercase letter!');
    } else if (!hasLowercase) {
      ErrorToast('Password must contain at least one lowercase letter!');
    } else if (!hasDigits) {
      ErrorToast('Password must contain at least one number!');
    } else if (!hasSpecialCharacters) {
      ErrorToast('Password must contain at least one special character (e.g., !@#\$&*~)!');
    }
    else if(FormValues['password']!=FormValues['cpassword']){
      ErrorToast('Confirm password should be same!');
    }
    else{
      setState(() {_isLoading=true;});
      bool res=await RegistrationRequest(FormValues);
      // bool res = true;
      if(res==true){
        // SuccessToast("Hurrah! Your registration is in processing....");
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
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
                  ? (Center(child: CircularProgressIndicator()))
                  : Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Join with us',
                              style: Head1Text(colorBlack),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: AppInputDecoration("Email"),
                            onChanged: (TextValue) {
                              InputOnChange("email", TextValue);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: AppInputDecoration("First Name"),
                            onChanged: (TextValue) {
                              InputOnChange("firstName", TextValue);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: AppInputDecoration("Last Name"),
                            onChanged: (TextValue) {
                              InputOnChange("lastName", TextValue);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: AppInputDecoration("Mobile"),
                            onChanged: (TextValue) {
                              InputOnChange("mobile", TextValue);
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: PasswordInputDecoration("Password",
                                _isPasswordVisible, togglePasswordVisibility, context),
                            onChanged: (TextValue) {
                              InputOnChange("password", TextValue);
                            },
                            obscureText: !_isPasswordVisible,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: PasswordInputDecoration(
                                "Confirm Password",
                                _isCPasswordVisible,
                                toggleCPasswordVisibility,
                                context),
                            onChanged: (TextValue) {
                              InputOnChange("cpassword", TextValue);
                            },
                            obscureText: !_isCPasswordVisible,
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                              onPressed: (){
                                FormOnSubmit();
                              },
                              child: ArrowButton(),
                          style: AppButtonStyle(),),
                          SizedBox(height: 5,),
                          TextButton(
                              onPressed: (){
                                Navigator.pushNamedAndRemoveUntil(context, "/login", (route)=> false);
                              },
                              child: RichText(text: TextSpan(
                                  text: "Have account? ", style: Head8Text(colorBlack,),
                                  children: [
                                    TextSpan(
                                      text: "Sign In", style: Head7Text(colorGreen),
                                    )
                                  ]
                              ))),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
