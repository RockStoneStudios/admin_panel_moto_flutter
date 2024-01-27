import 'package:adminpanel/dasboard/side_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCtww-gR5p0vQlRRb5p22aNs2_DoZGqWNg",
          authDomain: "moto-flutter.firebaseapp.com",
          databaseURL: "https://moto-flutter-default-rtdb.firebaseio.com",
          projectId: "moto-flutter",
          storageBucket: "moto-flutter.appspot.com",
          messagingSenderId: "273984987549",
          appId: "1:273984987549:web:b07287bb8041ff517d4f74",
          measurementId: "G-XGT0SZFWXT"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const SideNavigationDrawer());
  }
}
