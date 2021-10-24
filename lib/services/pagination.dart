import 'package:contacts_app/models/Contact.dart';
import 'package:flutter/material.dart';

import 'api_calls.dart';

class ContactPagination extends ChangeNotifier{
  List<Contact> contacts = [];
  var loading = false;
  var page =1;
  List<Contact> prev = [];

  ContactPagination(){
    getContacts();
    print("hello");
  }

  Future<void> getContacts() async
  {
    loading = true;
    print(page);
    notifyListeners();
    List<Contact> results = await Services.getContactsByPage(page);
    if(results.isNotEmpty && results!=prev)
    {
      
      if(prev.length==10 || prev.length==0)
      {  
        prev=results;
        contacts = [...contacts,...results];
        if(results.length==10)
        page=page+1;
      }
      else{
        
        contacts.addAll(results.getRange(prev.length, results.length));
        prev=results;
        if(results.length==10)
        page+=1;
      }
    }
    loading=false;
    notifyListeners();
  }


}