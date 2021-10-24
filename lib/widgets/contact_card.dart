import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactCard extends StatelessWidget{
  final firstName;
  final lastName;
  final email;
  ContactCard({this.firstName,this.lastName,this.email});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          CircleAvatar(
            radius: 37,
            backgroundColor: Colors.purple,
            child: Text(firstName[0]+(lastName!=""?lastName[0]:""), style: TextStyle(fontSize: 35),),
          ),
          SizedBox(height: 10,),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(firstName+" "+(lastName!=""?lastName:""),
                style: TextStyle(fontSize: 20),),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
  
}