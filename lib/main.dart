import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
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
      //  This is used if future is not used.
  //await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // Future representa un posible valor que será disponible en el futuro.
    // En este caso vera si se logro recuperar la instancia de Firebase. 
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      /*
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: const Center(
        child: Text('Conexión exitosa.'),
      ),
      ),
      */ 

      // FutureBuilder Ayuda a determinar el estado del Future y que mostrar si aún esta cargando. 
      home: FutureBuilder(
        future: _fbApp, // Que futuro voy a estar monitoreando
        builder: (context, snapshot) { // Se llama al inicio o cuando hay un cambio en el estado del Futuro.
          // Revisa si hubo un error al recuperar la instancia de Firebase.
          if (snapshot.hasError){
            print('Hubo un error. ${snapshot.error.toString()}');
            return Text('Error al inicializar Firebase.');
          }
          // Revisa si la instancia de Firebase se recupero exitosamente.  
          else if (snapshot.hasData){
            DatabaseReference _testRef = FirebaseDatabase.instance.ref().child("test");
            _testRef.set("Testing ${Random().nextInt(100)}"); 
            return Scaffold(
              appBar: AppBar(
                title: const Text('Material App Bar'),
              ),
              body: const Center(
                child: Text('Conexión exitosa.'),
              ),
            ); 
          }
          // Si aún esta buscando, muestra un indicador de espera. 
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },   
      ),
    );
  }
}