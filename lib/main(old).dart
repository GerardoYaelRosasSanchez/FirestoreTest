import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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




      /*
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
            // Guardar información en Realtime database.
            DatabaseReference _testRef = FirebaseDatabase.instance.ref().child("test");
            _testRef.set("Testing ${Random().nextInt(100)}"); 
            
            // Guardar información en Cloud Firestore.
            /*
            _fbFirestore.collection("users").add(user).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}')); 
            _fbFirestore.collection("users").add(user2).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
            */


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
      */
    
    );
  }

  // Función ayncrona.
    // Una función asyncrona crea un thread para correr la parte del código que esta
    // esperando respuesta y la parte del código que no require esperar respuesta.
    // Se puede usar await que menciona que promete una respuesta en el futuro y se
    // puede utilizar then si es obligatorio recibir una respuesta para continuar.

  // Clase Future.
    // Un futuro representa el resultado de una operación asyncrona y puede tener dos estados:
    // Completado o incompleto.
    // Incompleto espera a que la función regrese un error o o termine la operación.
    // Completo: Future completa el valor que se esta esperando o regresa un error.
    // Future dice que se regresará un valor de tipo Future en la función.
    // Si no regresa un valor. Por default regresa Future<void>
  Future createUser({required String first}) async {

    // .instance crea una instancia de la base de datos en Firestore.
    // .collection menciona en que colección se agregara la información.
      // La conexión tiene que existir para agregar la información.
    // .doc menciona en que documento se agregara la información.
      // El id es utilizado para identificar el document, en este caso my-id. 
      // Si no se agrega nada en .doc el ID se generara automáticamente.
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
    // Como otra opción tambien se pueden utizar objetos de tipo user.


    // Await espera a que el futuro sea completado. 
    // En este caso espera a que se inserten los valores en la base de datos.
      // Aquí se inserta la información mencionada en el documento.
      // Si la llave no existe se crea y si ya existe se modifica.
    await docUser.set(user) ;

    // Instancia para probar la implementación de objetos.
      // .doc como no tiene datos, se genera automáticamente.
    final docUser2 = FirebaseFirestore.instance.collection("users").doc(); 

    // Creo mi objeto de tipo usuario.
    final objectUser = User(
      // docUser.id guarda el id utilizado en el documento.
      // Nos permite acceder al id generado por el documento.
      id: docUser2.id,
      first: first,
      last: "Rosas",
      born: "2007",
    );

    // Combertir la información del objeto a formato Json. 
    final userToJson = objectUser.toJson();

    // Subir la información a la base de datos. 
    await docUser2.set(userToJson);

  }

}

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

  /*
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    first = json['first'];
    last = json['last'];
    born = json['born'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['first'] = this.first;
    data['last'] = this.last;
    data['born'] = this.born;

    return data;
  }
  */
}