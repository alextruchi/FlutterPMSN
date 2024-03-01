import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class introPage2 extends StatefulWidget {
  const introPage2({super.key});

  @override
  State<introPage2> createState() => _introPage2State();
}

class _introPage2State extends State<introPage2> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  bool bookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple[300],
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 250,
                height: 250,
                left: 0,
                child: Lottie.network("https://lottie.host/9c374188-71b5-446b-9931-1e517c85f7da/sUFypsEvOz.json")
              ),
              Positioned(
                top: 40,
                child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Es facil de usar!!'),
                      ],
                      repeatForever: true,
                      onTap: () {
                        
                      },
                    ),
                  )
              ),
              Positioned(
                top: 150,
                height: 200,
                left: 195,
                child: Lottie.network("https://lottie.host/0bbd901c-0960-4bee-a1e8-81217f6cef45/pTKdNyNIGK.json")
              ),
              Positioned(
                top: 320,
                left: 200,
                child: Image.asset("images/paso2.png", height: 50,)
              ),
              Positioned(
                top: 380,
                left: 210,
                width: 180,
                child: Text("Da un 'toque' a este icono y listo", style: TextStyle(fontSize: 20, color: Colors.white),)
              ),
              Positioned(
                top: 430,
                left: 220,
                height: 150,
                child: GestureDetector(
                onTap: () {
                  if (bookmarked == false) {
                    bookmarked = true;
                    _controller.forward();
                  } else {
                    bookmarked = false;
                    _controller.reverse();
                  }
                },
                child: Lottie.network(
                    "https://lottie.host/1d1be01c-084f-4e77-b079-89ff028ea429/K03vWeH9Pq.json",
                    controller: _controller),
                )
              ),
              Positioned(
                top: 120,
                left: 130,
                child: Image.asset("images/paso1.png", height: 50,)
              ),
              Positioned(
                top: 130,
                left: 195,
                child: Text("Busca tu pizza favorita", style: TextStyle(fontSize: 20, color: Colors.white),)
              ),
              Positioned(
                top: 590,
                left: 85,
                child: SizedBox(
                    width: 300.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Canterbury',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ScaleAnimatedText(' El mejor precio'),
                          ScaleAnimatedText('La mejor calidad'),
                          ScaleAnimatedText('El mejor servicio'),
                        ],
                        repeatForever: true,
                        onTap: () {
                          
                        },
                      ),
                    ),
                  )
              )
            ],
          ),

          /*child: GestureDetector(
            onTap: () {
              if(bookmarked == false){
                bookmarked = true;
                _controller.forward();
              }else{
                bookmarked = false;
                _controller.reverse();
              }
            },
            child: Lottie.network(
              "https://lottie.host/464125f1-4645-44f2-bf26-82a7d9ca32d3/aTQDFR6ooc.json",
              controller: _controller
            ),
          )*/
        ),
      ),
    );
  }
}