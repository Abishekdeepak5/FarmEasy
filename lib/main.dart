import 'package:farmeasy/pages/userlocation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async  {
   WidgetsFlutterBinding.ensureInitialized();
   
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(FarmeasyApp());
  if(kIsWeb){
    Firebase.initializeApp(
      options:const FirebaseOptions(
        apiKey: "AIzaSyD_5KNojH4pI6o5HV00LToEObCiaJBIdVI",
        authDomain: "farmeasy-sih.firebaseapp.com",
        projectId: "farmeasy-sih",
        storageBucket: "farmeasy-sih.appspot.com",
        messagingSenderId: "597752276151",
        appId: "1:597752276151:web:cf4e7bc18ab732f807d932",
        measurementId: "G-RE2E71CYWT"
      ));
  }else{
    Firebase.initializeApp();
  }
}

class FarmeasyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmeasy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckLocation(),
    );
  }
}
