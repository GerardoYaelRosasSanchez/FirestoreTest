import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  // Initialize Firebase Library
    // Allows to proccess session start events.
    // Sign User in.
  // Needed to access binary messeger before runApp() has been called.
    // Solves the error.
  WidgetsFlutterBinding.ensureInitialized();
    // Await le dice a Flutter que no inicie la aplicación hasta que inicie Firebase.
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

//void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}