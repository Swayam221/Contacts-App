import 'package:contacts_app/services/pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider<ContactPagination>(
        create: (context) => ContactPagination(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Contacts App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(title: 'Contacts'),
        ),
      );
  }
}
