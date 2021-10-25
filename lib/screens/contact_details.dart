import 'package:contacts_app/models/Contact.dart';
import 'package:contacts_app/services/api_calls.dart';
import 'package:contacts_app/services/pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class SingleContactPage extends StatefulWidget {
  final Contact contact;

  SingleContactPage({required this.contact}) : super();
  _SingleContactState createState() => _SingleContactState();

  Contact get getContact => contact;
}  
class _SingleContactState extends State<SingleContactPage>{
  var contact;
  bool loading = false;
  var pagination ;

  @override
  void initState(){
    super.initState();
    contact = widget.contact;
  }
  
  @override
  Widget build(BuildContext context) {

    pagination = Provider.of<ContactPagination>(context);
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
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFF44336),
                              Color(0xFFEF5350),
                              Color(0xFFE57373),
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
                        showDialog<String>(
                          context: context, 
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text('Are you sure you want to Delete the Contact for ${contact.firstName} ${contact.lastName}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  try{
                                    var response = await Services.deleteContact(contact.id);
                                    int i=0;
                                    for(var x in pagination.contacts)
                                    {
                                      
                                      if(x.id==contact.id)
                                      {
                                        pagination.deleteC(i);
                                        break;
                                      }
                                      i++;
                                    }
                                    i=0;
                                    for(var x in pagination.prev)
                                    {
                                      
                                      if(x.id==contact.id)
                                      {
                                        pagination.deleteP(i);
                                        break;
                                      }
                                      i++;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Contact deleted.")));
                                    Navigator.pop(context);  
                                    Navigator.pop(context);  
                                  }
                                  catch(err)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Error while deleting contact.")));
                                    Navigator.pop(context);    
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: !loading?const Text('Delete Contact'):CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),)
          ]),
        ),
      ),
    );
  }
}