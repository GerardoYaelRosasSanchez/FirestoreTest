import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  // Initialize Firebase Library
    // Allows to proccess session start events.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // Future representa un posible valor que será disponible en el futuro.
    // En este caso vera si se logro recuperar la instancia de Firebase. 
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {

    // Actualizar la información que agrega el usuario al Text field.
    final controller = TextEditingController(); 

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
          title: TextField(controller: controller),
          actions: [
            IconButton(
              onPressed: () {

                final first = controller.text; 
                createUser(first: first); 

              }, 
              icon: Icon(Icons.add), 
            )
          ],
        ),
      )
    
    );
  }

  // Lambda or Arrow function in Dart.
    // Return a value of an expressión.
    // Only one value can be returned. 
  // Stream
    // Igual que future, espera hasta recibir información, pero a diferencia del Future
    // stream puede recibir im error o un grupo de información. 
    // Funciona esperando información, cuando llega la pasa al código y espera al siguiente
    // lote para después pasarlo al código.
  Stream<List<User>> readUser() => FirebaseFirestore.instance.collection("users")
  .snapshots()
  .map((snapshot) => 
  snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  // Agregar usuario a la base de datos.
  Future createUser({required String first}) async {

    final docUser3 = FirebaseFirestore.instance.collection("users").doc("my-id")
    .collection("recetas").doc("Baños");

    // Crear un nuevo servicio.
    final servicio = <String, dynamic> {
      "id": 02,
      "Servicio": "Baño",
      "precio": 200,
    }; 

    // Agregar el servicio en la base de datos.
    await docUser3.set(servicio) ;

    /*
    // Posicionarme en una colección y crear un documento en esa colección.
    final docUser = FirebaseFirestore.instance.collection("users").doc('my-id'); 

    // Crear ususarios de prueba.
    final user = <String, dynamic> {
      "first": first,
      "last": "Rosas",
      "born": "2000" 
    }; 
    final user2 = <String, dynamic>{
      "first": "Raul",
      "middle": "Ignacio",
      "last": "Espinal",
      "born": 2000
    };

    // En este caso espera a que se inserten los valores en la base de datos.
    await docUser.set(user) ;

    // Instancia para probar la implementación de objetos.
    final docUser2 = FirebaseFirestore.instance.collection("users").doc(); 

    // Creo mi objeto de tipo usuario.
    final objectUser = User(
      id: docUser2.id,
      first: first,
      last: "Rosas",
      born: "2007",
    );

    // Convertir la información del objeto a formato Json. 
    final userToJson = objectUser.toJson();

    // Subir la información a la base de datos. 
    await docUser2.set(userToJson);
    */
  }

}

//Obejto Usuario
class User {
  String? id;
  String? first;
  String? last;
  String? born;

  User({
    this.id = '',
    required this.first,
    required this.last,
    required this.born,
  });

  // Convierte la información en 
  Map<String, dynamic> toJson() => {

    "id": id,
    "first": first,
    "last": last,
    "born": born, 
  };

}