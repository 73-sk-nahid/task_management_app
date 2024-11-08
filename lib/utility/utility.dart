import 'package:shared_preferences/shared_preferences.dart';

Future<void> SaveUserToken(UserData) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", UserData["token"]);
  print("user token saved successfully");
}

Future<void> WriteEmailVerification(Email) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("emailVerify", Email);
}

Future<void> WriteOTPVerification(OTP) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("OTPVerification", OTP);
}

Future<String?> ReadUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? Token = await prefs.getString("token");
  return Token;
}

Future<void> SaveUserDetails(UserData) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("email", UserData["data"]["email"]);
  await prefs.setString("firstName", UserData["data"]["firstName"]);
  await prefs.setString("lastName", UserData["data"]["lastName"]);
  await prefs.setString("mobile", UserData["data"]["mobile"]);
}

Future<String?> GetUserDetails(key) async{
  final prefs = await SharedPreferences.getInstance();
  String? myData = await prefs.getString(key);
  return myData;
}