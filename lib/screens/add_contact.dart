import 'dart:html';

import 'package:contacts_app/services/api_calls.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget{

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContactPage>{

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState()
  {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add A Contact"),
        leading: Icon(Icons.contact_mail_outlined),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 20,),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "firstName",
                ),
                validator: (val) => val!.isEmpty ? 'the contact must have a firstName': null,
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "lastName",
                ),
                // validator: (val) => val!.isEmpty ? 'the contact must have an lastName': null,
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "email",
                ),
                validator: (val) => val!.isEmpty ? 'the contact must have an email': !isEmail(val)? 'please enter a valid email' : null,
              ),
              const SizedBox(height: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate())
                        {
                          setState(() {
                            loading = true;
                          });
                          var response = await Services.addContact(firstNameController.text,lastNameController.text,emailController.text);
                          if(response=='')
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("An error occured while uploading contact details."),
                          ));
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Contact Added to Database Successfully"),
                            ));
                            Navigator.pop(context);
                          }
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: !loading?const Text('Add Contact To Database'):CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ],
          ),),
        ),
      ),
    );
  }

  bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

}