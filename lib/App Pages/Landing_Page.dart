import 'package:assingment/App%20Pages/record.dart';
import 'package:assingment/App%20Pages/settings_page.dart';
import 'package:assingment/App%20Pages/userdata%20-%20Copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Video recording/camera.dart';
import '../login_page/login.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
List<IconData> navIcons = [
  Icons.explore,
  Icons.add,
  Icons.settings,
];
List<String> navTitle = [
  "Explore",
  "Post",
  "Settings",
];
int selectedIndex = 0;
bool? login;
class _HomepageState extends State<Homepage> {
  @override
  Widget Active_Screen = Explorer();
  void initState() {
    // is_login_check();
    get_user_data();
    super.initState();
  }

  // void is_login_check()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   login = prefs.getBool('is_login');
  //   if(login==null){
  //     prefs.setBool('is_login',false);
  //     print("print login is Null");
  //   }
  //   login = prefs.getBool('is_login');
  //   print(" print login is $login ");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:login!?Stack(
        children: [
          Active_Screen,
          Align(alignment: Alignment.bottomCenter, child: _navBar())
          
        ],
      ):VLogin()
    );
  }
  Widget _navBar() {
    return Container(
      height: 55.h,
      margin: EdgeInsets.only(
        right: 24.w,
        left: 24.w,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 20,
              spreadRadius: 10,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: navIcons.map((icon) {
          int index = navIcons.indexOf(icon);
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  if (selectedIndex==0)Active_Screen=Explorer();
                  else if (selectedIndex==1)Active_Screen=VCamera();
                  else if (selectedIndex==2)Active_Screen=Setting();
                });
              },
              child: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 35.w,
                        right: 35.w,
                      ),
                      child: Icon(
                        icon,
                        color: isSelected ? Colors.pinkAccent : Colors.grey,
                      ),
                    ),
                    Text(
                      navTitle[index],
                      style: TextStyle(
                        color: isSelected ? Colors.pinkAccent : Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}



