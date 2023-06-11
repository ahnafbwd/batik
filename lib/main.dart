import 'package:flutter/material.dart';
import 'package:batik/users/fragment/dashboard_fragment.dart';
import 'package:batik/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:batik/users/authentication/login_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.data == null) {
            return LoginScreen();
          } else {
            return DashboardFragment();
          }
        },
      ),
    );
  }
}


//https://www.youtube.com/watch?v=Mhl6lwU4qEY&t=13s&ab_channel=DearProgrammer