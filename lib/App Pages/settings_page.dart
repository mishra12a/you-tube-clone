import 'package:assingment/App%20Pages/Landing_Page.dart';
import 'package:assingment/App%20Pages/userdata%20-%20Copy.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> with TickerProviderStateMixin {
  bool is_signin = login!;
  Column? settings;
  @override
  void initState() {
    settings = buildColumn();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    setState(() {});
  }

  final TextEditingController _nameController = TextEditingController();
  String name = '';
  ImageProvider? avatarImage;
  OverlayEntry? overlayEntry;
  AnimationController? controller;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        avatarImage = FileImage(File(pickedImage.path));
      });
    }
  }

  void _showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;
    final offset = renderbox.localToGlobal(Offset.zero);
    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hideOverlay,
        child: Material(
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.only(bottom: 40.h, right: 20.w, left: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content vertically
                children: [
                  Container(
                      width: double.infinity,
                      height: 130.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 204, 186, 248),
                            Color.fromARGB(255, 102, 78, 255)
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(children: [
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Data['username'],
                                    style: GoogleFonts.bevan(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                                SizedBox(height: 5),
                                Text(Data['email'],
                                    style: GoogleFonts.bevan(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ]),
                          Spacer(),
                          CircleAvatar(
                            backgroundImage: avatarImage ??
                                NetworkImage(Data[
                                    'image_url']), // Provide default avatar
                            radius: 30.r,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                _pickImage();
                                setState(() {});
                              },
                            ),
                          ),
                        ]),
                      )),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name...',
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final getData =
                                  await SharedPreferences.getInstance();
                              if (_nameController.text.isNotEmpty) {
                                getData.setString(
                                    'username', _nameController.text);
                                get_user_data();
                                print(Data);
                              }
                              setState(() {});
                              _hideOverlay(); // Pop overlay
                              _nameController.clear();
                            },
                            child: Text(
                              'Save',
                              style: GoogleFonts.dmSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              _hideOverlay(); // Pop overlay
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.dmSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry!);
  }

  void _hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  double x = 50.0;
  double y = 100.0;

  void updateProgress(double newX, double newY) {
    setState(() {
      x = newX.clamp(0.5, y); // Clamp x within 0 and y
      y = newY.clamp(1.0, double.infinity); // Clamp y to minimum 1.0
    });
  }

  @override
  Widget build(BuildContext context) {
    double progressRatio = x / y;

    // Define a tween for animating between two colors
    final Animation<Color?> valueColorTween = ColorTween(
      begin: Colors.blue,
      end: Colors.green,
    ).animate(controller!);

    return Scaffold(
        backgroundColor: Color(0xFF191A1F),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${Data['image_url']}'),
                  radius: 50.r,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('My Profile',
                  style: GoogleFonts.bevan(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF7B58B2))),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Account',
                          style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B58B2))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 204, 186, 248),
                              Color.fromARGB(255, 102, 78, 255)
                            ],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.w))),
                      padding: EdgeInsets.all(8.w),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(Data['image_url']),
                          radius: 20.r,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Data['username'],
                                    style: GoogleFonts.bevan(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF7B58B2))),
                                Text(Data['email'],
                                    style: GoogleFonts.bevan(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF7B58B2))),
                              ]),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _showOverlay,
                          child: Icon(Icons.create)
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              settings = buildColumn();
                            });
                          },
                          child: Text('Settings',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF7B58B2))),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              settings = buildColumn_support();
                            });
                          },
                          child: Text('Support',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF7B58B2))),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              settings = buildColumn_About();
                            });
                          },
                          child: Text('About',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF7B58B2))),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.w)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.w),
                          child: settings),
                    ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    //   clipBehavior: Clip.antiAlias,
                    //   decoration: BoxDecoration(
                    //       color: const Color.fromARGB(255, 247, 247, 247),
                    //       borderRadius: BorderRadius.circular(12.r)),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Image(
                    //               image: AssetImage(
                    //                   'lib/Assets/png/Frame 6939geminai.png')),
                    //           SizedBox(
                    //             width: 3,
                    //           ),
                    //           Text(
                    //             'Credits',
                    //             style: GoogleFonts.dmSans(
                    //               fontSize: 16.sp,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 8.0, horizontal: 5),
                    //         child: LinearProgressIndicator(
                    //           value: progressRatio, // Set progress based on ratio
                    //           backgroundColor: Colors.grey[200],
                    //           color: Colors.purple,
                    //           valueColor: valueColorTween,
                    //         ),
                    //       ),
                    //       Text(
                    //         '$x/$y Credits used',
                    //         style: GoogleFonts.dmSans(
                    //           fontSize: 12.sp,
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Social',
                          style: GoogleFonts.dmSans(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B58B2))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),),
                      child: Column(
                        children: [
                          setting_card(
                              image_resource: Icons.insert_comment,
                              text: 'Follow us on Instagram'),
                          const Divider(color: Colors.grey, height: 2),
                          setting_card(
                              image_resource:
                              Icons.close,
                              text: 'Follow us on X (Twitter)'),
                          const Divider(color: Colors.grey, height: 2),
                          setting_card(
                              image_resource: Icons.facebook,
                              text: 'Follow us on Facebook'),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: is_signin
                          ? TextButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                                await Future.delayed(Duration(seconds: 2));
                                // Log_out();
                                Navigator.of(context).pop;
                              },
                              child: Text('Logout',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            )
                          : TextButton(
                              onPressed: () {},
                              child: Text('Sign In',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  Column buildColumn() {
    return Column(
      children: [
        // setting_card(
        //     image_resource: 'lib/Assets/png/mask_group_720.png',
        //     text: 'Language'),
        // const Divider(color: Colors.grey, height: 2),
        GestureDetector(
          onTap: showDeleteHistoryDialog,
          child: setting_card(
              image_resource: Icons.history,
              text: 'Clear History'),
        ),
        // const Divider(color: Colors.grey, height: 2),
        // setting_card(
        //     image_resource: 'lib/Assets/png/mask_group__2__720.png',
        //     text: 'Voice'),
        // const Divider(color: Colors.grey, height: 2),
        // setting_card(
        //     image_resource: 'lib/Assets/png/ellipse_3193_720.png',
        //     text: 'Color'),
      ],
    );
  }

  void showDeleteHistoryDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Material(
            color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Confirm History Deletion',
                          style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                      Divider(),
                      Text(
                          'This action cannot be undone and chat history will be permanently removed.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold))),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.delete),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text('Delete',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Column buildColumn_support() {
    return Column(
      children: [
        setting_card(image_resource: Icons.help_outline, text: 'Help'),
        // const Divider(color: Colors.grey, height: 2),
        // setting_card(
        //     image_resource: 'lib/Assets/png/mask_group__4__720.png',
        //     text: 'Restore Purchase'),
        const Divider(color: Colors.grey, height: 2),
        setting_card(
            image_resource: Icons.request_page, text: 'Request a feature'),
      ],
    );
  }

  Column buildColumn_About() {
    return Column(
      children: [
        setting_card(image_resource: Icons.star_rate_outlined, text: 'Rate Us'),
        const Divider(color: Colors.grey, height: 2),
        setting_card(image_resource: Icons.share, text: 'Share'),
        const Divider(color: Colors.grey, height: 2),
        setting_card(
            image_resource: Icons.event_note_outlined, text: 'Terms of Use'),
        const Divider(color: Colors.grey, height: 2),
        setting_card(
            image_resource: Icons.policy,
            text: 'Privacy Policy'),
      ],
    );
  }
}

class setting_card extends StatelessWidget {
  setting_card({
    required this.text,
    required this.image_resource,
    super.key,
  });
  String text;
  final image_resource;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Leading icon
            Icon(image_resource),
            const SizedBox(width: 16.0),
            // Text content
            Expanded(
              child: Text(
                text,
                  style: GoogleFonts.dmSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
              ),
            const Icon(Icons.chevron_right,color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
