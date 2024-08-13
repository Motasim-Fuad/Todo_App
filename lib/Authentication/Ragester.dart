import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart'as http;
import 'package:todoapp/Authentication/Login.dart';



import 'package:todoapp/Utils/Utils.dart';

import 'package:todoapp/Resources/Component/inputfeld.dart';
import 'package:todoapp/Resources/Component/RoundButton.dart';

import '../Resources/Configration/AppUrl.dart';

class Ragister extends StatefulWidget {
  const Ragister({Key? key}) : super(key: key);

  @override
  State<Ragister> createState() => _RagisterState();
}


class _RagisterState extends State<Ragister> {
  TextEditingController txemail=TextEditingController();
  TextEditingController txpassword=TextEditingController();

  void Register()async{
    if(txemail.text.isNotEmpty && txpassword.text.isNotEmpty){
      try{
        var reqbody ={
         'email':txemail.text,
          'password':txpassword.text,
          };

        var responce= await http.post(
          Uri.parse(registerurl),
          headers: {"Content-Type" :"application/json"},
          body: jsonEncode(reqbody),
        );
        var jsonResponce =jsonDecode(responce.body);
        print(jsonResponce["status"]);
        if(jsonResponce["status"]){
          Utils.snackBar("Thank you!", "Your ragistration Completed");
          Get.off(Login());
        }else{
          Utils.snackBar("Sorry", "some thimg wrong");
        }

      }catch(e){
        debugPrint("$e");
      }

    }else{
      Utils.snackBar("msg", "text field is empty");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(

            child: Column(
              children: [
                Container(

                  margin:const EdgeInsets.only(top: 200),
                  child: Column(
                    children: [
                      const  Text("Sing up"),
                      InputFeld(controler: txemail,hindtext: "email",),
                      const SizedBox(height: 5,),
                      InputFeld(controler: txpassword,hindtext: "password",),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                RoundedButton(title: "Sing UP", onPress: () {

                  Register();

                },),
                const   SizedBox(height: 5,),
                Row(
                  children: [
                    const   Text("if you  have account go to"),
                    TextButton(onPressed: (){
                      Get.off(Login());
                    }, child: const Text("login page")),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}



