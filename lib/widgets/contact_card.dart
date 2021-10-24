import 'package:contacts_app/models/Contact.dart';
import 'package:contacts_app/screens/contact_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactCard extends StatelessWidget{
  final Contact contact;
  ContactCard({required this.contact});
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SingleContactPage(contact: contact))
          ),
          child: Card(
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
                  child: Text(contact.firstName[0]+(contact.lastName!=""?contact.lastName[0]:""), style: TextStyle(fontSize: constraints.maxHeight/5),),
                ),
                SizedBox(height: 20,),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(contact.firstName+" "+(contact.lastName!=""?contact.lastName:""),
                      style: TextStyle(fontSize: constraints.maxHeight/10),),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        );
      },
    );
  }
  
}