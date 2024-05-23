import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
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

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      body: Stack(
        children: [Align(alignment: Alignment.bottomCenter, child: _navBar())],
      ),
    );
  }

  Widget _navBar() {
    return Container(
      height: 65,
      margin: EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 15,
                        bottom: 0,
                        left: 35,
                        right: 35,
                      ),
                      child: Icon(
                        icon,
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                    ),
                    Text(
                      navTitle[index],
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
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