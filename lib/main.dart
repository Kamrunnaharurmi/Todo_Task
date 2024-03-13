import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'start.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBj0K9ryVYr_vpQ0zgd0aTfUXXkVpYIkM0',
        appId: '1:907957668309:android:8f92920e5261bfcf71d55c',
        messagingSenderId: '907957668309',
        projectId: 'todoapp-584ab',
        storageBucket: 'todoapp-584ab.appspot.com',
      )
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: start(),
    );
  }
}
