import 'package:flutter/material.dart';
import 'package:psmn2/screens/login_screen.dart';
import 'package:psmn2/screens/onBoarding_screen.dart';
import 'package:splash_view/source/presentation/pages/pages.dart';
import 'package:splash_view/source/presentation/presentation.dart';

class splashScreen extends StatelessWidget { //Se le tiene que hacer ctrl. para importar el material
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundColor: Colors.green[600], //Se puede indicar la intensidad
      logo: Image.network("https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png", height: 256,),
      loadingIndicator: CircularProgressIndicator(),//Image.asset("images/loading.gif"), //Que proviene del pubspec
      done: Done(
        const onBoardingScreen(),
        animationDuration: const Duration(milliseconds: 3000)
      ),
    );
  }
}