import 'package:contacts_app/screens/add_contact.dart';
import 'package:contacts_app/services/api_calls.dart';
import 'package:contacts_app/widgets/contact_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/Contact.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Contact> contacts = [];
  var gridController = ScrollController();
  var searchController = TextEditingController();
  @override
  void initSate(){
    super.initState();
    gridController.addListener((){
      if(gridController.position.pixels == gridController.position.maxScrollExtent)
      {

      }
    });
  }

  Future<void> getContacts() async
  {
    contacts = await Services.getContacts();
    setState(() {
      
    });
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
  }

  @override 
  Widget build(BuildContext context)
  {
    getContacts();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.8),
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (val) async
            {},
          ),
        ),
      ),
      body: Column(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child:GridView.builder(
              controller: gridController,
              primary: false,physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: !kIsWeb?2:4,
                // children: books.map((i) => BookCard(title: i.title,author: i.author,publishDate: i.datePublished)).toList(),
              ),
              itemCount: contacts.length,
              itemBuilder: (context,index) {
                return ContactCard(contact: contacts[index],);
              },
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { 
          await _navigate(context);
        },
        tooltip: 'Add A Contact',
        child: Icon(Icons.add),
      ), 
    );
  }
  Future<void> _navigate(BuildContext context) async { 
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddContactPage()
      )
    );
  }
}