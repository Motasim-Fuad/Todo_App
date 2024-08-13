import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../Resources/Configration/AppUrl.dart';
import '../../Utils/Utils.dart';

class TodoListControler extends GetxController{
  // RxList<String> item=new List<String>.generate(10, (i) => "iteam ${i+1}").obs;

  RxList dataItem = [].obs;

     Future getTodoList(userId) async {

       // akhana amra jahatu jata responce hisaba pathiya , data ar responce nitasie , tai post method used hoisa ,,
       //bakend a method ta post hoba

       //get method ar khatra amra sudu data ar responce pabo ,but responce pathata parbo na ,tai get method used hoy nai,
      var reqBody = {
        "userId":userId
      };
      var response = await http.post(Uri.parse(showToDoUrl),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body.toString());
      dataItem.value = jsonResponse['success'];
      return jsonResponse['success'];


    }

     void deleteItem(id,userId) async{
       var reqBody = {
         "id":id
       };
       var response = await http.post(Uri.parse(deleteTodo),
           headers: {"Content-Type":"application/json"},
           body: jsonEncode(reqBody)
       );
       var jsonResponse = jsonDecode(response.body);
       if(jsonResponse['status']){
        getTodoList(userId);
       }
     }

//   var request = http.Request(
//     'GET',
//     Uri.parse(showToDoUrl),
//   )..headers.addAll({
//     "Content-Type" :"application/json"
//   });
//   var params = {
//     "userId":userId,
//   };
//   request.body = jsonEncode(params);
//   http.StreamedResponse response = await request.send();
//   print(response.statusCode);
//   print(await response.stream.bytesToString());
//
// }


  void addToDoData(context,todoTitle,todoDescription,userId,)async{

    if(todoTitle.text.isNotEmpty && todoDescription.text.isNotEmpty){
      try{
        var reqbody ={
          'userId':userId,
          'title':todoTitle.text,
          'description':todoDescription.text,
        };

        var responce= await http.post(
          Uri.parse(storeToDoUrl),
          headers: {"Content-Type" :"application/json"},
          body: jsonEncode(reqbody),
        );

        // debugPrint("add data : ${responce.body}");

        var jsonResponce =jsonDecode(responce.body);
        debugPrint("add data status : ${jsonResponce["success"]}");
        if(jsonResponce["status"]){
          todoTitle.clear();
          todoDescription.clear();
          Utils.snackBar("Thank you!", "Data Add Successful");
          Navigator.pop(context);
          getTodoList(userId);
        }else{
          Utils.snackBar("Sorry", "some thimg wrong");
        }

      }catch(e){
        debugPrint("error is : $e");
      }

    }else{
      Utils.snackBar("msg", "text field is empty");
    }

  }

  void updateData(context,todoTitle,todoDescription,dataId,userId)async{

    if(todoTitle.text.isNotEmpty && todoDescription.text.isNotEmpty){
      try{
        var reqbody ={
          'dataId':dataId,
          'title':todoTitle.text,
          'description':todoDescription.text,
        };

        var responce= await http.post(
          Uri.parse(updateTodoList),
          headers: {"Content-Type" :"application/json"},
          body: jsonEncode(reqbody),
        );

        var jsonResponce =jsonDecode(responce.body);

        if(jsonResponce["status"]){
          todoTitle.clear();
          todoDescription.clear();
          Utils.snackBar("Thank you!", "Update Successful");
          Navigator.pop(context);
          getTodoList(userId);
        }else{
          Utils.snackBar("Sorry", "some thimg wrong");
        }

      }catch(e){
        debugPrint("error is : $e");
      }

    }else{
      Utils.snackBar("msg", "text field is empty");
    }

  }


}