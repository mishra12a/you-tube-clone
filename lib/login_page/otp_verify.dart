import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Phone_Auth.dart';

class OVerify extends StatefulWidget {
  const OVerify({super.key, required this.varificationID});
  final String varificationID;
  @override
  State<OVerify> createState() => _OVerifyState();
}

class _OVerifyState extends State<OVerify> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController otpcontroller = TextEditingController();

      verifyOTP() async {
      String result = await PhoneAuthentication().verifyOTPcode(
      verifyID: widget.varificationID, otp: otpcontroller.text.toString());

      if (result == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully signed in!')),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Verification Failed'),
            duration: Duration(seconds: 1),
          ), // SnackBar
        );
      }

    }

    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            CircleAvatar(
              radius: 35.r,
            ),
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Verify',
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            // SizedBox(
            //   height: 5.h,
            // ),
            TextField(
              controller: otpcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.all(8.0),
                labelText: 'Enter OTP',
                labelStyle: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF7B58B2),
                  ),
                ),
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
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            Row(
              children: [
                Text(
                  'Did not get OTP ?',
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend',
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            SizedBox(
              width: 210.w,
              height: 40.h,
              child: ElevatedButton(
                onPressed:verifyOTP,
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B58B2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.r), // Rounded corners
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 100.h,
            // ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  //size: 36.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),

      // #191A1F,
    );
  }
}
