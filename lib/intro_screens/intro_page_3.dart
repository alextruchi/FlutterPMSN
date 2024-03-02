import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class introPage3 extends StatelessWidget {
  const introPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[200],
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 140,
              height: 300,
              child: Lottie.network("https://lottie.host/03992da6-dee0-4cb0-b2bf-881b73b4c537/Pr16SZND8n.json"),
            ).animate().fadeIn(duration: 2500.ms),
            Positioned(
                top: 40,
                child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Excelente ayuda a el cliente!!'),
                      ],
                      repeatForever: true,
                      onTap: () {
                        
                      },
                    ),
                  ).animate().fadeIn(duration: 2000.ms).scale()
              ),
            Positioned(
              top: 500,
              child: SizedBox(
                  width: 300.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Tienes alguna duda?'),
                        TypewriterAnimatedText('Escribenos!!!'),
                        TypewriterAnimatedText('Atención al cliente las 24 hrs'),
                      ],
                      repeatForever: true,
                      onTap: () {
                        
                      },
                    ),
                  ),
                )
            ),
            Positioned(
              top: 110,
              left: 290,
              child: Lottie.network("https://lottie.host/892d93d4-4cdc-4974-a7c4-53049cabb565/pO6CrPqNVd.json", height: 100)
            )
          ],
        ),
      ),
    );
  }
}