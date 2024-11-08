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
    print(resultBody);
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
  var URL = Uri.parse("$baseURL/RecoverVerifyEmail/$Email");
  var response = await get(URL);
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

Future<bool> VerifyOTPRequest(Email, OTP) async{
  var URL = Uri.parse("$baseURL/RecoverVerifyOtp/$Email/$OTP");
  var response = await get(URL);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){
    await WriteOTPVerification(OTP);
    SuccessToast("OTP Verification Successful");
    return true;
  }
  else {
    ErrorToast("OTP Verification Failed");
    return false;
  }
}




Future<List> TaskListRequest(Status) async {
  var URL=Uri.parse("${baseURL}/listTaskByStatus/${Status}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return ResultBody['data'];
  }
  else{
    ErrorToast("Request fail ! try again");
    return [];
  }
}

Future<bool> TaskCreateRequest(FormValues) async {

  var URL=Uri.parse("${baseURL}/createTask");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};

  var PostBody=json.encode(FormValues);

  var response= await http.post(URL,headers:RequestHeaderWithToken,body: PostBody);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}


Future<bool> TaskDeleteRequest(id) async {
  var URL=Uri.parse("${baseURL}/deleteTask/${id}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}


Future<bool> TaskUpdateRequest(id,status) async {
  var URL=Uri.parse("${baseURL}/updateTaskStatus/${id}/${status}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}