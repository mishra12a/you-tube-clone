import 'dart:io';
import 'package:assingment/Video%20recording/display.dart';
import 'package:assingment/Video%20recording/save.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;

class VCamera extends StatefulWidget {
  const VCamera({super.key});

  @override
  State<VCamera> createState() => _VCameraState();
}

class _VCameraState extends State<VCamera> {
  String? _videoURL;
  String? _thumbnailURL;
  VideoPlayerController? _controller;
  String? vid_downloadURL;
  String? Image_downloadURL;
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('&&&&&&&&&&&&&&&&&&&&&  $vid_downloadURL && $Image_downloadURL');
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Image(
                    image: AssetImage('Assets/Premium.png'),
                    height: 50.h,
                    width: 50.w,
                  ),
                  Text(
                    'Flyin',
                    style: GoogleFonts.josefinSans(
                      textStyle: TextStyle(
                          letterSpacing: 5,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Upload Video',
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      letterSpacing: 2,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                color: Colors.grey.withOpacity(0.1),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                        child: _videoURL != null
                            ? _VideoPreviewWidget()
                            : GestureDetector(
                                onTap: _pickVideo,
                                child: Container(
                                  width: double.infinity,
                                  height: 200.h,
                                  color: Colors.black,
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_circle_outlined,
                                          color: Colors.white,
                                          size: 30.sp,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'Add Video',
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 50.h, // Adjust the height as needed
                      child: TextField(
                        controller: _titleController,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 50.h, // Adjust the height as needed
                      child: TextField(
                        controller: _categoryController,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Category',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        _thumbnailURL = await pickimage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Add thumbnail',
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Add location',
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 210.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_categoryController.text.isNotEmpty &&
                        _categoryController.text.isNotEmpty &&
                        _thumbnailURL != null &&
                        _videoURL != null) {
                      _UploadVideo();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please fill all the details')),
                      );
                    }
                  },
                  child: Text(
                    'Post Video',
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
              SizedBox(height: 100.h),
              // Text('_videoURL  will be here = $_videoURL'),
              // SizedBox(
              //   height: 10,
              // ),
              // Text('_downloadURL will be here = $_downloadURL'),
            ],
          ),
        ),
      ),
    );
  }

  void _pickVideo() async {
    _videoURL = await pickVideo();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  Widget _VideoPreviewWidget() {
    if (_controller != null) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextButton(
            onPressed: _pickVideo,
            child: Text(
              'Change Media',
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          )
        ],
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void _UploadVideo() async {
    vid_downloadURL = await StoreData().uploadVideo(_videoURL!);
    Image_downloadURL = await StoreData().uploadImage(_thumbnailURL!);
    await StoreData().saveVideoData(
        videoDownloadUrl: vid_downloadURL!,
        thumbnail: Image_downloadURL!,
        catagory: _categoryController.text.toString(),
        profile_pic: 'profile_pic',
        title: _titleController.text.toString(),
        user_name: 'user_name',
        views: '0',
        like_count: '0');
    setState(() {
      _videoURL = null;
    });
  }
}
