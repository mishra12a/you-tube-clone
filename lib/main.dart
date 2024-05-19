import 'package:assingment/login_page/login.dart';
import 'package:assingment/login_page/otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //         apiKey: 'AIzaSyAzM8Aqjp2PvDYeGjIVrXfjzj5CCY9jR4A',
  //         appId: "1:349788433410:android:e50c855357ba6b71ba8b1b",
  //         messagingSenderId: '',
  //         projectId: "appi-f885c"));
  // String? token = await FirebaseMessaging.instance.getToken();
  // print("FCM Token: $token");
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
        home: VLogin(),
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
       
//         home:VLogin(),
      
//     );
//   }
// }


