import 'package:contacts_app/models/Contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSingleInfoRow extends StatelessWidget {
  const ContactSingleInfoRow({
    required this.singleInfo,
    required this.singleIcon
  }) : super();

  final String singleInfo;
  final IconData singleIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        onTap: () async => await launch("mailto:$singleInfo"),
        contentPadding: EdgeInsets.only(top: 6, left: 24, bottom: 6),
        title: Center(
          child: Row(
            children: [
              Icon(
                singleIcon,
                size: 28,
              ),
              SizedBox(width: 10,),
              Text("$singleInfo", 
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleContactPage extends StatelessWidget {
  final Contact contact;

  SingleContactPage({required this.contact}) : super();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Center(
          child: Column(
            children: [
            Center(
              child: CircleAvatar(
                radius: height/12,
                backgroundColor: Colors.purple,
                child: Text(contact.firstName[0]+(contact.lastName!=""?contact.lastName[0]:""), style: TextStyle(fontSize: height/16),),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Column(children: [
              Padding(padding: EdgeInsets.only(left: 20),
                child: Text(
                  "${contact.firstName} ${contact.lastName}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ]),
            SizedBox(
              height: 28,
            ),
            Column(
              children: [
                Center(
                  child: ContactSingleInfoRow(
                    singleInfo: contact.email,
                    singleIcon: Icons.email_outlined,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}