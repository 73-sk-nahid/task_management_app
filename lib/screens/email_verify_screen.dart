import 'package:flutter/material.dart';
import 'package:task_management_app/api/api_client.dart';
import 'package:task_management_app/style/style.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool _isLoading = false;
  Map<String, String> FormValues = {
    "email":""
  };

  ItemOnChange(MapKey, TextValue){
    setState(() {
      FormValues.update(MapKey, (value)=> TextValue);
    });
  }

  FormOnSubmit() async {
    // Email validation with a regex
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    if(FormValues['email']!.isEmpty){
      ErrorToast("Please Enter an email");
    }
    else if(!emailRegExp.hasMatch(FormValues['email']!)){
      ErrorToast("Please enter valid email");
    }
    else {
      setState(() {_isLoading=true;});
      bool res=await VerifyEmailRequest(FormValues["email"]);
      if(res==true){
        // SuccessToast("An OTP sent to your email....");
        Navigator.pushNamedAndRemoveUntil(context, "/pinVerify", (route) => false);
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
                      padding: const EdgeInsets.all(30.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Email Address",
                              style: Head1Text(colorDarkBlue),
                            ),
                            Text("A 6 digit verification pin will send to your email address",
                            style: Head6Text(colorLightGray),),
                            SizedBox(height: 20.0,),
                            TextFormField(
                              decoration: AppInputDecoration("Email"),
                              onChanged: (TextValue){
                                ItemOnChange("email", TextValue);
                              },
                            ),
                            SizedBox(height: 20.0,),
                            ElevatedButton(
                                onPressed: (){
                                  FormOnSubmit();
                                },
                                child: ArrowButton(),
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
