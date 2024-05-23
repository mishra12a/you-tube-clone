import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App Pages/Landing_Page.dart';
import 'App Pages/record.dart';
import 'Video recording/camera.dart';
import 'login_page/login.dart';

String? token;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyA4ZMao8NaZzaYxEbJ-ycZPTcz0FepuL00',
          appId: "1:10777654946:android:90c665bc619242878009fb",
          messagingSenderId: '10777654946',
          projectId: "assessment-593d7"));
  
  token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");
  is_login_check();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Homepage(),
      ),
    );
  }
}
void is_login_check()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  login = prefs.getBool('is_login');
  if(login==null){
    prefs.setBool('is_login',false);
    print("print login is Null");
  }
  login = prefs.getBool('is_login');
  print(" print login is $login ");
}


