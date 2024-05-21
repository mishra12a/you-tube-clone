import 'package:assingment/login_page/otp_verify.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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

    sendOTP(BuildContext ctx) async {
      await PhoneAuthentication().sendOTPcode(controller.text.toString(),
          (String veri_ID) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wait for OTP')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OVerify(varificationID:veri_ID ,),
            ));
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            CircleAvatar(
              radius: 40.r,
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Create Your Account',
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),

            TextField(
              controller: controller,
              //initialCountryCode: "IN",
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.all(8.0),
                labelText: 'Enter Mobile Number',
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
                // prefixIcon: Container(
                //   padding: EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       showCountryPicker(
                //           context: context,
                //           countryListTheme: CountryListThemeData(

                //             textStyle: TextStyle(color: Colors.black),
                //             bottomSheetHeight: 600.h,
                //           ), onSelect: (value) {
                //             setState(() {
                //               selectdCountry = value;
                //             });
                //           });
                //     },
                //     child: Text(
                //       "${selectdCountry.flagEmoji} + ${selectdCountry.phoneCode}",
                //       style: GoogleFonts.josefinSans(
                //         textStyle: TextStyle(
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white),
                //       ),
                //     ),
                //   ),
                // )),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // SizedBox(
            //   height: 10.h,
            // ),

            Row(
              children: [
                const Icon(
                  Icons.check_box_outline_blank,
                  color: Color(0xFF7B58B2),
                ),
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
              height: 40.h,
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
