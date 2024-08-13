import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final title;
  final VoidCallback onPress;
  const RoundedButton({Key? key,required this.title,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onPress,
      child: Container(
          height:MediaQuery.of(context).size.height*0.08,
          width:MediaQuery.of(context).size.width*0.3,

          decoration: BoxDecoration(
            boxShadow: const[
                BoxShadow(
                color: Colors.white70,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),

            ],
            color: Colors.black87,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2,color: Colors.blue),
          ),
          child:
          Center(
            child: Text(title,style: const TextStyle(color: Colors.white),),
          )
      ),
    );
  }
}
