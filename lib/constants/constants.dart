import 'package:flutter/material.dart';

class Constans{
 static  TextStyle getTitleTextStyle(){
    return TextStyle(
      color:Colors.white,
      fontWeight:FontWeight.bold,
      fontFamily: "PinyonScript" ,
      fontSize:24); 
  }
  static TextStyle completedTaskTextStyle(){
    return TextStyle(
    decoration: TextDecoration.lineThrough,
    color: Colors.grey,
    fontFamily: "PinyonScript"
    );
  }
  static TextStyle taskTimeTextStyle(){
    return  TextStyle(fontSize: 14, color: Colors.grey,fontFamily: "PinyonScript");

  }
}