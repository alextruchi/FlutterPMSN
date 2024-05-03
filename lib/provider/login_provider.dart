import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{
  //Variables para ver si ya se logueo o no, siempre deben de ser privadas las variables en el provider
  bool _isLogued = false;

  //Este es un metodo de get para la variable
  bool get isLogued => _isLogued;

  //Este es un metodo set para la variable
  set isLogued(bool value){
    this._isLogued = value;
    //Se debe de notificar a todos los que esten escuchando que hubi un cambio de variable
    notifyListeners();
  }


}