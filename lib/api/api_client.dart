import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_management_app/style/style.dart';

var baseURL = "http://152.42.163.176:2006/api/v1";
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
    SuccessToast("Login Success");
    return true;
  }
  else {
    ErrorToast("Login Failed. Try again");
    return false;
  }
}