import 'dart:io';
import 'dart:core';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psmn2/services/email_auth_firebase.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {

  final emailAuthFirebase = EmailAuthFirebase();

  File? _imagenSeleccionada = null;

  bool isFoto = false;
  bool isContra = false;

  final conEmail = TextEditingController();
  final conNombre = TextEditingController();
  final conContra = TextEditingController();

  FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {

    
    final txtEmail = TextFormField(
      keyboardType: TextInputType.text,
      focusNode: _focusNode,
      controller: conEmail,
      onEditingComplete: () {
        if (_compEmail(conEmail.text)){
          var snackbar = SnackBar(content: Text("El email es correcto.."));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          _focusNode.unfocus();
        }else{
          var snackbar = SnackBar(content: Text("El email es incorrecto.."));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          _focusNode.unfocus();
        }
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Escribe tu email...",
      ),
      
    );

    final txtNombre = TextFormField(
      keyboardType: TextInputType.text,
      controller: conNombre,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Escribe tu nombre...",
      ),
      
    );

    final txtContra = TextFormField(
      keyboardType: TextInputType.text,
      controller: conContra,
      obscureText: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Escribe tu contraseña...",
      ),
      
    );

    final btnGaleria = ElevatedButton.icon(
      icon: const Icon(Icons.photo_album, color: Colors.black,),
      label: const Text("Elegir foto desde galeria", style: TextStyle(color: Colors.black),),
      onPressed: (){
        _elegirFoto();
      },
    );

    final btnCamara = ElevatedButton.icon(
      icon: const Icon(Icons.camera, color: Colors.black,),
      label: const Text("Tomar foto con la camara", style: TextStyle(color: Colors.black),),
      onPressed: (){
        _fotoCamara();
      },
    );

    final btnGuardar = ElevatedButton.icon(
      onPressed: (){
        if(conEmail.text=="" || conNombre.text=="" || conContra.text=="" || _imagenSeleccionada==null || isContra==false){
          //Se le agrego un .then para que se espere a que acabe ese codigo
            var snackbar = SnackBar(content: Text("Faltan datos por agregar.."));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }else{
          emailAuthFirebase.signUpUser(name: conNombre.text, password: conContra.text, email: conEmail.text).then((value) {
          var snackbar = SnackBar(content: Text("El usuario se ha agregado.."));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          });
        }
      },
      icon: Icon(Icons.send, color: Colors.black,),
      label: Text("Registrar usuario", style: TextStyle(color: Colors.black),)
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fondo_registro.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            /*isFoto ? Positioned(
              top: 35,
              child: Image.file(_imagenSeleccionada!, height: 140,)
              ):  Positioned(
                top: 35,
                child: Image.asset("images/foto_registro.png", height: 140,),
              ),*/
            Positioned(
            top: 35,
            child: ClipOval(child: _imagenSeleccionada !=null ? Image.file(_imagenSeleccionada!, height: 140,) : Image.asset("images/foto_registro.png", height: 140,))
            ),
            Positioned(
              top: 200,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                height: 84,
                width: MediaQuery.of(context).size.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email_outlined),
                    SizedBox(height: 10,),
                    Expanded(child: txtEmail)
                  ],
                ),
              ),
            ),
            Positioned(
              top: 300,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                height: 84,
                width: MediaQuery.of(context).size.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(height: 10,),
                    Expanded(child: txtNombre)
                  ],
                ),
              ),
            ),
            Positioned(
              top: 400,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                height: 84,
                width: MediaQuery.of(context).size.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.password),
                    SizedBox(height: 10,),
                    Expanded(child: txtContra),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 500,
              child: new FlutterPwValidator(
                      width: 350,
                      height: 140,
                      minLength: 8,
                      onSuccess: (){
                        isContra = true;
                      },
                      onFail: (){
                        isContra = false;
                      },
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                      controller: conContra
                    )
            ),
            Positioned(
              top: 650,
              child: Container(
                child: btnCamara
              ),
            ),
            Positioned(
              top: 700,
              child: Container(
                child: btnGaleria
              ),
            ),
            Positioned(
              top: 750,
              child: Container(
                child: btnGuardar
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            )
            /*Positioned( //Codigo para hacer un recuadro de texto
              top: 176,
              left: 21,
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                ),
                child: Column(
                  children: [
                    Text("Email de usuario:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,

                    ),
                    ),
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Future _elegirFoto() async {
    final imagenObtenida = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagenObtenida == null) {
      return;
    }

    setState(() {
      _imagenSeleccionada = File(imagenObtenida!.path);
      //isFoto = !isFoto;
    });
  }

  Future _fotoCamara() async {
    final imagenObtenida = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagenObtenida == null) {
      return;
    }

    setState(() {
      _imagenSeleccionada = File(imagenObtenida!.path);
      //isFoto = !isFoto;
    });
  }

  bool _compEmail(String email){
    final bool isValid = EmailValidator.validate(email);
    return isValid;
  }
}