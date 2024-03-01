import 'package:flutter/material.dart';
import 'package:psmn2/intro_screens/intro_page_1.dart';
import 'package:psmn2/intro_screens/intro_page_2.dart';
import 'package:psmn2/intro_screens/intro_page_3.dart';
import 'package:psmn2/screens/dashboard_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {

  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              introPage1(),
              introPage2(),
              introPage3()
            ],
          ),

          Container(
            alignment: Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*GestureDetector(
                  child: Text("Skip"),
                  onTap: (){
                    _controller.jumpToPage(2);
                  },
                ),*/
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  icon: Icon(Icons.double_arrow, color: Colors.black,),
                  label: Text("Saltar", style: TextStyle(color: Colors.black),)
                ),
                SmoothPageIndicator(controller: _controller, count: 3,),
                onLastPage ?
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/dash");
                  },
                  icon: Icon(Icons.exit_to_app, color: Colors.black,),
                  label: Text("Hecho", style: TextStyle(color: Colors.black),)
                )
                /*GestureDetector(
                  child: Text("Done"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashBoardScreen();
                        }
                      )
                    );
                  },
                )*/
                : ElevatedButton.icon(
                  onPressed: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: Icon(Icons.arrow_right_alt, color: Colors.black,),
                  label: Text("Siguiente", style: TextStyle(color: Colors.black),)
                ),
                /*GestureDetector(
                  child: Text("Next"),
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                )*/
              ],
            ),
          )
        ],
      )
    );
  }
}