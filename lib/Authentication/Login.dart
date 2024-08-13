import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'as http;
import 'package:todoapp/Authentication/Ragester.dart';

import 'package:todoapp/Screen/home/homeScreen.dart';
import 'package:todoapp/Utils/Utils.dart';

import 'package:todoapp/Resources/Component/inputfeld.dart';

import 'package:todoapp/Resources/Component/RoundButton.dart';

import '../Resources/Configration/AppUrl.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController txemail=TextEditingController();
  TextEditingController txpassword=TextEditingController();

  late SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedpre();
  }

  void initSharedpre()async{
    preferences = await SharedPreferences.getInstance();

  }


  void loginUser()async{
    if(txemail.text.isNotEmpty && txpassword.text.isNotEmpty){

      var reqbody ={
        'email':txemail.text,
        'password':txpassword.text,
      };


      var responce= await http.post(
        Uri.parse(loginurl),
        headers: {"Content-Type" :"application/json"},
        body: jsonEncode(reqbody),
      );
      var jsonResponce =jsonDecode(responce.body);
      if(jsonResponce["status"]){
        var myToken= jsonResponce['token'];
        preferences.setString("token", myToken);
        Get.off(HomeScreen(token:myToken));

      }else{
        Utils.snackBar("message", "some thing wrong");
      }
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
                      const Text("Login"),
                      InputFeld(controler: txemail,hindtext: "email",),
                      const  SizedBox(height: 5,),
                      InputFeld(controler: txpassword,hindtext: "password",),
                    ],
                  ),
                ),
                const  SizedBox(height: 5,),
                RoundedButton(title: "Login", onPress: () {
                  loginUser();

                },),
                const  SizedBox(height: 5,),
                Row(
                  children: [
                    const   Text("if you don't have account go to"),
                    TextButton(onPressed: (){
                      Get.off(Ragister());
                    }, child:const Text("Ragister page")),
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




