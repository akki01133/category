import 'package:category/HomeScreen.dart';
import 'package:category/api/ApiCalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snoodify App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Snoodify App'),
      // TODO - start coding here
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context)=>UserRepository(),
        child:  const HomeScreen(),
      ),

    );
  }
}

