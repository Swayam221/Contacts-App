import 'package:contacts_app/screens/add_contact.dart';
import 'package:contacts_app/services/api_calls.dart';
import 'package:contacts_app/services/pagination.dart';
import 'package:contacts_app/widgets/contact_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'models/Contact.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Contact> contacts = [];
  var pagination ;
  var gridController = ScrollController();
  var searchController = TextEditingController();
  bool loading = false;
  List<Contact> searchResults = [];
  var searching = false;

  @override
  void initState(){
    super.initState();
    
    gridController.addListener((){
      if(gridController.position.pixels == gridController.position.maxScrollExtent)
      {
        pagination.getContacts();
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
    // this.pagination = Provider.of<ContactPagination>(context);
  }

  @override 
  Widget build(BuildContext context)
  {
    // getContacts();
    // pagination = Provider.of<ContactPagination>(context);
    pagination = Provider.of<ContactPagination>(context);
    pagination.addListener((){
      contacts = pagination.contacts;
      loading = pagination.loading;
    });
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
            {
              if(searchController.text.isNotEmpty)
              {
                setState(() {
                  searching=true;
                });
                List<Contact> sR = await Services.search(searchController.text);
                setState(() {
                  searchResults = sR;
                });
              }
              else {
                setState(() {
                  searching = false;  
                });
                
              }
            },
          ),
        ),
      ),
      body: !searching? Column(
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
          if(loading)
          CircularProgressIndicator(),
        ]
      ):searchResults.isNotEmpty?Column(
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
              itemCount: searchResults.length,
              itemBuilder: (context,index) {
                return ContactCard(contact: searchResults[index],);
              },
            ),
          ),
        ]
      ):Center(
        child: Text("No Resutls for This Query", style: TextStyle(fontSize: 16),),
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
    pagination.getContacts();
  }
}