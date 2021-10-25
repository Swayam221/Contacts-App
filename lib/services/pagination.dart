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
  }

  Future<void> getContacts() async
  {
    loading = true;
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

  void deleteC(int index) {
    contacts.removeAt(index);
    notifyListeners();
  }
  void deleteP(int index) {
    if(prev.length==10)
    {
      page=page-1;
    }
    prev.removeAt(index);
    notifyListeners();
  }
}