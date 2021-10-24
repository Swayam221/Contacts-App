import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactCard extends StatelessWidget{
  final firstName;
  final lastName;
  final email;
  ContactCard({this.firstName,this.lastName,this.email});
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        return Card(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              CircleAvatar(
                radius: constraints.maxHeight/5,
                backgroundColor: Colors.purple,
                child: Text(firstName[0]+(lastName!=""?lastName[0]:""), style: TextStyle(fontSize: constraints.maxHeight/5),),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(firstName+" "+(lastName!=""?lastName:""),
                    style: TextStyle(fontSize: constraints.maxHeight/10),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        );
      },
    );
  }
  
}