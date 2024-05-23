import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoRecord extends StatefulWidget {
  const VideoRecord({super.key});

  @override
  State<VideoRecord> createState() => _VideoRecordState();
}

class _VideoRecordState extends State<VideoRecord> {
   final TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        backgroundColor: Color(0xFF191A1F),
        title: Row(
          children: [

            Text(
              'Flyin',
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    letterSpacing: 5,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 50.w,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {}, // Handle search action
          ),
       
        ],
      ),
      body: Center(
        child: Column(
          children: [
              TextField(
              controller: controller2,
              //initialCountryCode: "IN",
              decoration: InputDecoration(
                  //contentPadding: EdgeInsets.all(8.0),
                  labelText: 'Search',
                  labelStyle: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF7B58B2),
                    ),
                  ),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.filter_list_outlined),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.r),
                      borderSide: BorderSide(
                        color: Color(0xFF7B58B2),
                        width: 1.w,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.r),
                      borderSide: BorderSide(
                        color: Color(0xFF7B58B2),
                        width: 1.w,
                      )),
              ),
                  style:TextStyle(
    color: Colors.black, 
  ),
            ),
            SizedBox(
              height: 20.h,
            ),
           Container(
          height: 200..h, // Set the height of the rectangle
          width: 300.w,  // Set the width of the rectangle
          decoration: BoxDecoration(
            color: Colors.black, // Background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            border: Border.all(
              color: Colors.grey, // Border color
              width: 2.0, // Border width
            ),
          ),
          child: Center(
            child: Icon(Icons.play_arrow,
            color: Colors.white,)
          ),
        ),
          SizedBox(
              height: 20.h,
            ),
        Container(
            height: 200..h, // Set the height of the rectangle
          width: 300.w,   // Set the width of the rectangle
          decoration: BoxDecoration(
            color:  Colors.black, // Background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            border: Border.all(
              color: Colors.grey, // Border color
              width: 2.0, // Border width
            ),
          ),
          child: Center(
            child: Icon(Icons.play_arrow,
            color: Colors.white,
            )
          ),
        ),
          ],
        ),
      ),
    );
  }
}
