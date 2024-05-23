import 'package:assingment/login_page/otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Phone_Auth.dart';

class VLogin extends StatefulWidget {
  const VLogin({super.key});

  @override
  State<VLogin> createState() => _VLoginState();
}

class _VLoginState extends State<VLogin> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController userID_controller = TextEditingController();
    bool? rememberme = true;
    sendOTP(BuildContext ctx) async {
      await PhoneAuthentication().sendOTPcode(controller.text.trim().toString(),
          (String veri_ID) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wait for OTP')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OVerify(userid:userID_controller.text,
                varificationID: veri_ID,
                Phonenumber: controller.text.toString(),
              ),
            ));
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            Image(
              image: AssetImage('Assets/Premium.png'),
              width: 120.w,
              height: 120.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Create Your \nAccount',
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              controller: userID_controller,
              decoration: InputDecoration(
                labelText: 'User Name',
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
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
                hintText:"+91 0000000000",
                hintStyle:  TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white.withOpacity(0.2)),
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
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Checkbox(
                    value: rememberme,
                    onChanged: (bool? newval) {
                      setState(() {
                        rememberme = newval;
                      });
                    }),
                Text(
                  'Remember me',
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 210.w,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {
                  sendOTP(context);
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B58B2),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(22.r), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // #191A1F,
    );
  }
}
