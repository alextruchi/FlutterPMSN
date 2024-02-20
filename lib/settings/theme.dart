import 'package:flutter/material.dart';

class ThemeApp{ //Aqui se pueden definir tantos temas como se deseen
  ThemeData lightTheme(BuildContext context){//Se puede dejar sin el tipo de dato
    final theme = ThemeData.light(); //Con esto nos robaremos las caracteristicas del tema

    return theme.copyWith( //Se debe tener cuidado porque no todos las propiedades se pueden cambiar
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 255, 0, 0)
      )
    );
  }

  ThemeData darkTheme(BuildContext context){//Se puede dejar sin el tipo de dato
    final theme = ThemeData.dark(); //Con esto nos robaremos las caracteristicas del tema

    return theme.copyWith( //Se debe tener cuidado porque no todos las propiedades se pueden cambiar
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 6, 81, 6)
      )
    );
  }
}