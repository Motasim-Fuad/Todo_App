 import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils{

  static snackBar(String title,String message){
    Get.snackbar(
      title,
      message,

    );
  }
}