import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_app/api/api_client.dart';
import 'package:task_management_app/style/style.dart';
import 'package:task_management_app/utility/utility.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  bool _isLoading = false;

  Map<String, String> FormValues = {"otp": ""};

  InputOnChange(MapKey, TextValue) {
    setState(() {
      FormValues.update(MapKey, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues["otp"]!.length != 6) {
      ErrorToast("Pin required.");
    } else {
      setState(() {
        _isLoading = true;
      });
      String? Email = await GetUserDetails("emailVerify");
      bool res = await VerifyOTPRequest(Email, FormValues["otp"]);
      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
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
                      padding: EdgeInsets.all(30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pin Verification",
                              style: Head1Text(colorDarkBlue),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "A 6 digit pin has been send to your mobile number",
                              style: Head6Text(colorLightGray),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PinCodeTextField(
                              appContext: context,
                              length: 6,
                              pinTheme: AppOTPStyle(),
                              animationType: AnimationType.fade,
                              animationDuration: Duration(milliseconds: 300),
                              enableActiveFill: true,
                              onCompleted: (v) {},
                              onChanged: (TextValue) {
                                InputOnChange("otp", TextValue);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FormOnSubmit();
                              },
                              child: SuccessButtonChild("Verify"),
                              style: AppButtonStyle(),
                            ),
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
