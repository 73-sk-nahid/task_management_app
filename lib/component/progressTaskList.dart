import 'package:flutter/material.dart';
import '../style/style.dart';
import 'TaskList.dart';
import 'package:task_management_app/api/api_client.dart';

class progressTaskList extends StatefulWidget {
  const progressTaskList({Key? key}) : super(key: key);

  @override
  State<progressTaskList> createState() => _progressTaskListState();
}

class _progressTaskListState extends State<progressTaskList> {

  List TaskItems=[];
  bool Loading=true;
  String Status="Progress";

  @override
  void initState(){
    CallData();
    super.initState();
  }

  CallData() async{
    var data= await TaskListRequest("Progress");
    setState(() {
      Loading=false;
      TaskItems=data;
    });
  }

  UpdateStatus(id) async{
    setState(() {Loading=true;});
    await TaskUpdateRequest(id,Status);
    await CallData();
    setState(() {Status = "Progress";});
  }


  DeleteItem(id) async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Delete !"),
            content: Text("Onece delete, you can't get it back"),
            actions: [
              OutlinedButton(onPressed: () async {
                Navigator.pop(context);
                setState(() {Loading=true;});
                await TaskDeleteRequest(id);
                await CallData();
              }, child: Text('Yes')),
              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('No')),
            ],
          );
        }
    );
  }


  StatusChange(id) async{
    showModalBottomSheet(context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return Container(
                  padding: EdgeInsets.all(30),
                  height: 360,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioListTile(title: Text("New"), value: "New", groupValue: Status,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      RadioListTile(title: Text("Progress"), value: "Progress", groupValue: Status,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      RadioListTile(title: Text("Completed"), value: "Completed", groupValue: Status,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      RadioListTile(title: Text("Canceled"), value: "Canceled", groupValue: Status,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      Container(child: ElevatedButton(
                        style: AppButtonStyle(),
                        child: SuccessButtonChild('Confirm'),
                        onPressed: (){
                          Navigator.pop(context);
                          UpdateStatus(id);
                        },
                      ),)
                    ],
                  ),
                );
              }
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Loading?(Center(child: CircularProgressIndicator())):RefreshIndicator(
        onRefresh: () async {
          await CallData();
        },
        child: TaskList(TaskItems,DeleteItem,StatusChange)
    );
  }
}
