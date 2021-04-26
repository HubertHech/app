import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gohaupetsitter_app/AllScreens/loginScreen.dart';
import 'package:gohaupetsitter_app/AllScreens/mainscreen.dart';
import 'package:gohaupetsitter_app/AllScreens/petsitterInfo.dart';
import 'package:gohaupetsitter_app/AllScreens/registrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gohaupetsitter_app/DataHandler/appData.dart';
import 'package:gohaupetsitter_app/configMaps.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  currentfirebaseUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
DatabaseReference petsitterRef = FirebaseDatabase.instance.reference().child("petsitters");
DatabaseReference newRequestRef = FirebaseDatabase.instance.reference().child("Request");
DatabaseReference walkRequestRef = FirebaseDatabase.instance.reference().child("petsitters").child(currentfirebaseUser.uid).child("newWalk");


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'GOhau Petsitter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MainScreen.idScreen,
        routes:
        {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          PetsitterInfoScreen.idScreen: (context) => PetsitterInfoScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
