import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookCard extends StatelessWidget{
  final firstName;
  final lastName;
  final email;
  BookCard({this.firstName,this.lastName,this.email});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(firstName[0]+lastName!=""?lastName[0]:""),
          ),
          Text(firstName+"  "+lastName!=""?lastName:"")
        ],
      ),
    );
  }
  
}