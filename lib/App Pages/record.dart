import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../JSON/home_video.dart';
import 'video_detail_screen.dart';

class Explorer extends StatefulWidget {
  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  TextEditingController Search_controller = TextEditingController();
  final database = FirebaseFirestore.instance.collection('/Video_Info');

  Future<DocumentSnapshot> getDataOnce(String path) async {
    final firestore = FirebaseFirestore.instance;
    final reference = firestore.doc(path);
    final snapshot = await reference.get();
    return snapshot;
  }
  Future<void> fetch_data_firestore () async{
    await database.get().then(
          (querySnapshot) {
        print("Successfully completed");
        print(querySnapshot.docs.toString());
        // home_video.clear();
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          if (docSnapshot.data().isNotEmpty){
            home_video.add(docSnapshot.data());
          }
        }
        print(home_video);
        setState(() {

        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  @override
  void initState() {
    fetch_data_firestore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 25.sp,
                  color: Colors.white,
                ),
                onPressed: fetch_data_firestore,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: Search_controller,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
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
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(home_video.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoDetailScreen(
                              title: home_video[index]['title'],
                              viewCount: home_video[index]['views'],
                              username: home_video[index]['user_name'],
                              profile: home_video[index]['profile_pic'],
                              thumbnail: home_video[index]['thumb_nail'],
                              dayAgo: home_video[index]['upload_date'],
                              location:home_video[index]['location'],
                              likeCount: home_video[index]['like_count'],
                              unlikeCount: home_video[index]['unlike_count'],
                              videoUrl: home_video[index]['video_url'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.grey.withOpacity(0.4),
                            image: DecorationImage(
                                image: NetworkImage(
                                  home_video[index]['thumb_nail'],
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: NetworkImage('https://64.media.tumblr.com/9213b61d6d6dd328f18832081468f443/5c0a2988780f0154-29/s400x600/b0c7d850f7eb30c1db251f20d71a6b5e92c2c12a.png')
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: size.width - 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                home_video[index]['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: size.width - 120,
                                    child: Text(
                                      home_video[index]['user_name'] +
                                          " - " +
                                          home_video[index]['upload_date'] +
                                          " - " +
                                          home_video[index]['views'] +
                                          " - " +
                                          home_video[index]['location'] ,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 12,
                                          height: 1.5),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        SizedBox(height:80.h,)
      ],
    );
  }
}
