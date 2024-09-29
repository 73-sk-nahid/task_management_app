import 'package:flutter/material.dart';
import 'package:task_management_app/style/style.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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

  Map<String, String> FormValues = {
    "email":"",
    "password": "",
    "cpassword": ""
  };

  InputOnChange(MapKey, TextValue){
    setState(() {
      FormValues.update(MapKey, (value)=> TextValue);
    });
  }

  FormOnSubmit() async {
    String password = FormValues['password'] ?? '';
    String confirmPassword = FormValues['cpassword'] ?? '';

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#\$&*~]'));
    bool hasMinLength = password.length >= 8;

    if (password.isEmpty) {
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
      ErrorToast('Password must contain at least one special character!');
    } else if (password != confirmPassword) {
      ErrorToast('Confirm password should be the same!');
    } else {
      setState(() {
        _isLoading = true;
      });

      // Placeholder for registration function
      bool res = true;  // Replace with actual registration logic

      if (res == true) {
        SuccessToast("New password set successful....");
        // Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
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
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set New Password",
                        style: Head1Text(colorDarkBlue),
                      ),
                      Text("Minimum length password 8 character with number, uppercase, lowercase and symbol",
                        style: Head6Text(colorLightGray),),
                      SizedBox(height: 20.0,),
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
                      SizedBox(height: 20.0,),
                      ElevatedButton(
                        onPressed: (){
                          FormOnSubmit();
                        },
                        child: SuccessButtonChild("Set Password"),
                        style: AppButtonStyle(),),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
