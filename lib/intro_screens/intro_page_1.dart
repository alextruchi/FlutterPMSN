import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class introPage1 extends StatelessWidget {
  const introPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink[200],
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 140,
              height: 300,
              child: Lottie.network("https://lottie.host/855957ba-8166-4721-955e-d54d4ccf8b2d/t9DjWP7RtT.json"),
            ),
            Positioned(
                top: 40,
                child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Servicio a domicilio!!'),
                      ],
                      repeatForever: true,
                      onTap: () {
                        
                      },
                    ),
                  )
              ),
            Positioned(
              top: 500,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 20.0, height: 100.0),
                    const Text(
                      'Servicio disponible',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(width: 20.0, height: 100.0),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('las 24 hrs del dia!!'),
                          RotateAnimatedText('los 7 dias de la semana!!'),
                          RotateAnimatedText('los 365 dias del año!!'),
                        ],
                        onTap: () {
                          
                        },
                        repeatForever: true,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}