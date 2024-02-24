import 'package:flutter/material.dart';
import 'package:psmn2/screens/dashboard_screen.dart';
import 'package:psmn2/screens/despensa.dart';
import 'package:psmn2/screens/register_screen.dart';
import 'package:psmn2/screens/splash_screen.dart';
import 'package:psmn2/settings/app_value_notifier.dart';
import 'package:psmn2/settings/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(//Tendremos que envolver a materialApp en un builder para recibir el cambio del tema
      valueListenable: AppValueNotifiier.banTheme,
      builder: (context, value, child) {
        return MaterialApp( //El widget padre
          theme: value 
          ? ThemeApp().darkTheme(context)
          : ThemeApp().lightTheme(context),
          home: splashScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            "/dash" : (BuildContext context) => DashBoardScreen(),
            "/despensa":(BuildContext context) => DespensaScreen(),
            "/registro":(BuildContext context) => registerScreen(),
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