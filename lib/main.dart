import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_home_app/screens/controls_screen.dart';
import 'package:smart_home_app/screens/dht_readings_screen.dart';
import 'package:smart_home_app/screens/home_screen.dart';
import 'package:smart_home_app/screens/login_screen.dart';
import 'package:smart_home_app/screens/sensor_readings_screen.dart';
import 'package:smart_home_app/screens/signup_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/sensor_readings': (context) => SensorReadingsScreen(),
        '/dht_readings': (context) => DHTReadingsScreen(),
        '/controls': (context) => ControlsScreen(),
      },
    );
  }
}


