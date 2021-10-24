import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:contacts_app/models/Contact.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class Services{

  static String emulatorUrl = 'http://10.0.2.2:7000/';
  // static String emulatorUrl = 'http://localhost:7000/';
  static String addContactRoute = 'contacts/';
  static String editContactRoute = 'contacts/';
  static String deleteContactRoute = 'contacts/';
  static String pageSize = '10';
  //static String host = 'localhost:7000';

//add a contact
  static Future<String> addContact(String firstName, String lastName, String email) async {
    var body = json.encode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    });
    try{
      final response = await http.post(
        Uri.parse(emulatorUrl+addContactRoute),
        headers: {'content-type': 'application/json'},
        body: body,
      );
      return json.decode(response.body)['_id'];
      
    }
    catch(err)
    {
      return '';
    }
  } 

//edit a contact
  static Future<String> editContact(String id, String firstName, String lastName, String email) async {
    var body = json.encode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    });
    try{
      final response = await http.post(
        Uri.parse(emulatorUrl+addContactRoute+id),
        headers: {'content-type': 'application/json'},
        body: body,
      );
      return json.decode(response.body)['_id'];
      
    }
    catch(err)
    {
      return '';
    }
  } 

//delete a contact
  static Future<String> deleteContact(String id) async {
    try{
      final response = await http.delete(
        Uri.parse(emulatorUrl+deleteContactRoute+id),
      );
      return json.decode(response.body)['_id'];
      
    }
    catch(err)
    {
      return '';
    }
  } 
  
//get all contacts  
  static Future<List<Contact>> getContacts() async{
    try{
      
      final response = await http.get(
        Uri.parse(emulatorUrl+addContactRoute),
      );
      List<Contact> results = (json.decode(response.body) as List).map((i) => Contact.fromJson(i)).toList();
      return results;
    }
    catch(err){
      return [];
    }
  }
}