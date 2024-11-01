import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmn2/provider/login_provider.dart';
import 'package:psmn2/screens/dashboard_screen.dart';
import 'package:psmn2/screens/despensa.dart';
import 'package:psmn2/screens/detail_movie_screen.dart';
import 'package:psmn2/screens/favorite_movies_screen.dart';
import 'package:psmn2/screens/login_screen.dart';
import 'package:psmn2/screens/maps_screen.dart';
import 'package:psmn2/screens/onBoarding_screen.dart';
import 'package:psmn2/screens/popular_movies_screen.dart';
import 'package:psmn2/screens/register_screen.dart';
import 'package:psmn2/screens/products_firebase_screen.dart';
import 'package:psmn2/screens/splash_screen.dart';
import 'package:psmn2/settings/app_value_notifier.dart';
import 'package:psmn2/settings/theme.dart';

//Se debe de cambiar para usar firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey:
          "AIzaSyBEycR6Qx2wU4B2rKtqASVuKIvOF_6Vs6Y", // paste your api key here
      appId:
          "com.example.psmn2", //paste your app id here
      messagingSenderId: "62882916222", //paste your messagingSenderId here
      projectId: "pmsn2024-clase", //paste your project id here
    ),);
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Siempre se debe de instanciar en caso de usarse
    final loginprovider = Provider.of<LoginProvider>(context);
    return ValueListenableBuilder(//Tendremos que envolver a materialApp en un builder para recibir el cambio del tema
      valueListenable: AppValueNotifiier.banTheme,
      builder: (context, value, child) {
        return MaterialApp( //El widget padre
          theme: value 
          ? ThemeApp().darkTheme(context)
          : ThemeApp().lightTheme(context),
          //home: splashScreen(),
          home: loginprovider.isLogued ? DashBoardScreen() : loginScreen(),
          debugShowCheckedModeBanner: false,
          routes: { //Ponerle const hace que sea mas eficiente abrir un stateless
            "/dash" : (BuildContext context) => const DashBoardScreen(),
            "/despensa":(BuildContext context) => const DespensaScreen(),
            "/registro":(BuildContext context) => const registerScreen(),
            "/onBoarding": (BuildContext context) => const onBoardingScreen(),
            "/movies": (BuildContext context) => const PopularMoviesScreen(),
            //"/detail":(BuildContext context) => const DetailMovieScreen(),
            "/products":(BuildContext context) => const ProductsFirebaseScreen(),
            "/favorites":(BuildContext context) => const FavoriteMoviesScreen(),
            "/maps":(BuildContext context) => const MapSample(),
          },
        );
      }
    );
  }
}

/*class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador = 0; 
 //Al agregar variables aqui tendremos que quitar "const del constructor de la parte de arriba"
  @override
  Widget build(BuildContext context) {
    //int contador = 0; Cada vez que se de un clic en la interfaz esta variable volvera a valer 0.
    return MaterialApp(
      //Inicio del cuerpo de la interfaz
      home: Scaffold(
        appBar: AppBar(
          title: Text("Practica 1",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(), //Barra de navegacion lateral
        floatingActionButton: FloatingActionButton(//Boton flotante en el fondo
          onPressed: () {
            contador++;
            print(contador);
            setState(() {}); //Vuelve a realizar el renderizado para que si puedan cambiar las cosas
          },
          child: Icon(Icons.ads_click), //Elemento hijo del boton flotante
          backgroundColor: Colors.red,
        ),
        body: Column( //En la columna si se ordenan las cosas, para remover un widget se usa control y .
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network("https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png",
              height: 250,),
            ),
            Text("Valor del contador: $contador", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
          ],
        )
      ),
    );
  }
}
*/