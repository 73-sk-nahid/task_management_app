import 'package:flutter/material.dart';
import 'package:task_management_app/api/api_client.dart';
import 'package:task_management_app/style/style.dart';
import 'package:task_management_app/utility/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? _userToken;

  GetToken() async{
    String? Token = await GetUserDetails("token");
    // String? UserData = await GetUserDetails("Token");
    setState(() {
      _userToken = Token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                GetToken();
              }, child: Text("Get Data")),
              SizedBox(height: 20,),
              _userToken == null ?
              Text("Press Get Data", style: Head1Text(colorGreen),):
              Text(_userToken!, style: Head6Text(colorRed),),
            ],
          ),
      ),
    );
  }
}