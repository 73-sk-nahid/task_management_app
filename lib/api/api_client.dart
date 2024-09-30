import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_management_app/style/style.dart';
import 'package:task_management_app/utility/utility.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseURL = dotenv.env["baseURL"];
var requestHeader = {"content-type":"application/json"};

Future<bool> RegistrationRequest(FormValues) async{
  var URl = Uri.parse("${baseURL}/Registration");
  var postBody = json.encode(FormValues);
  var response = await post(URl, headers: requestHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){
    SuccessToast("Registration Success");
    return true;
  }
  else {
    ErrorToast("Registration Failed. Try again");
    return false;
  }
}

Future<bool> LoginRequest(FormValues) async{
  var URl = Uri.parse("${baseURL}/Login");
  var postBody = json.encode(FormValues);
  var response = await post(URl, headers: requestHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){
    await SaveUserToken(resultBody);
    // await SaveUserData(resultBody["token"]);
    SuccessToast("Login Success");
    return true;
  }
  else {
    ErrorToast("Login Failed. Try again");
    return false;
  }
}

Future<bool> SaveUserData(Token) async{
  var URL = Uri.parse("{$baseURL}/ProfileDetails");
  var response = await post(URL, headers: Token);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){
    await SaveUserDetails(resultBody);
    SuccessToast("Data Fetch Successful");
    return true;
  }
  else{
    ErrorToast("Data Fetch Failed");
    return false;
  }
}

Future<bool> VerifyEmailRequest(Email) async{
  var URL = Uri.parse("{$baseURL}/RecoverVerifyEmail/${Email}");
  var response = await post(URL);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){
    await WriteEmailVerification(Email);
    SuccessToast("An OTP sent to you email");
    return true;
  }
  else{
    ErrorToast("Data Fetch Failed");
    return false;
  }
}