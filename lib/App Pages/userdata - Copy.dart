import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
Map<String,dynamic>Data={};
void get_user_data()async{
  final getData=await SharedPreferences.getInstance();
  Data['username']=getData.getString('username')??'N/A';
  Data['image_url']= getData.getString('image_url')??'https://cdn-icons-png.flaticon.com/512/9131/9131529.png';
  Data['Token']= getData.getString('Token')??'N/A';
  Data['email']= getData.getString('email')??'N/A';
  Data['isLoggedIn']= getData.getBool('isLoggedIn')??false;
  print(Data);
}
Future clearSharedPrefs() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 await prefs.clear();
 print('data has been cleared');
 // Optionally, handle success or error
}