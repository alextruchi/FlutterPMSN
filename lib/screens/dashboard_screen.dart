import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:psmn2/network/api_popular.dart';
import 'package:psmn2/screens/popular_movies_screen.dart';
import 'package:psmn2/settings/app_value_notifier.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//Al hacer un navigator para cambiar de pantalla se generara una flecha en el appbar para poder volver
        backgroundColor: Colors.blue,
        title: Text("Dashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Rubensin Torres Frias"),
              accountEmail: Text("Ruben.torres@itcelaya.edu.mx"),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),),
              ),
              ListTile( //Se utiliza para manejar titulos y subtitulos en cada elemento, ademas de tener cosas a los lados
                leading: Icon(Icons.phone),
                title: Text("Moviles app"),
                subtitle: Text("Consulta de peliculas particulares"),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  ApiPopular().getSessionId();
                  Navigator.push(context, SlideLeftPageAnimation(page: PopularMoviesScreen()));
                },
              ),
              ListTile( //Se utiliza para manejar titulos y subtitulos en cada elemento, ademas de tener cosas a los lados
                leading: Icon(Icons.phone),
                title: Text("Products firebase"),
                subtitle: Text("Consulta de productos particulares"),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, "/products");
                },
              ),
              ListTile( //Se utiliza para manejar titulos y subtitulos en cada elemento, ademas de tener cosas a los lados
                leading: Icon(Icons.shop),
                title: Text("Mi despensa"),
                subtitle: Text("Relación de productos que no voy a usar"),
                trailing: Icon(Icons.chevron_right),
                onTap:() => Navigator.pushNamed(context, '/despensa'),
              ),
              ListTile( //Se utiliza para manejar titulos y subtitulos en cada elemento, ademas de tener cosas a los lados
                leading: Icon(Icons.close),
                title: Text("Practica 2"),
                subtitle: Text("Aqui iria la descripcion si tuviera una"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);//Se sale de la pantalla actual (en este caso del drawer)
                  Navigator.pop(context);
                },
              ),
              ListTile( //Se utiliza para manejar titulos y subtitulos en cada elemento, ademas de tener cosas a los lados
                leading: Icon(Icons.shop),
                title: Text("Mi mapas"),
                subtitle: Text("Mapa de ejemplo de google"),
                trailing: Icon(Icons.chevron_right),
                onTap:() => Navigator.pushNamed(context, '/maps'),
              ),
              DayNightSwitcher(
              isDarkModeEnabled: AppValueNotifiier.banTheme.value,
              onStateChanged: (isDarkModeEnabled) {//Quitamos la parte del setState ya que eso solo seria para la pantalla actual
                AppValueNotifiier.banTheme.value = isDarkModeEnabled;
              },
            ),
          ],
        ),
      ),
    );
  }
}