

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:psmn2/provider/login_provider.dart';
import 'package:psmn2/screens/dashboard_screen.dart';
import 'package:psmn2/services/email_auth_firebase.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final authfirebase = EmailAuthFirebase();
  
  bool isloading = false;

  final conEmail = TextEditingController();
  final conContra = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<LoginProvider>(context);

    final textUser = TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: conEmail,
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );

  final pwdUser = TextFormField(
    keyboardType: TextInputType.text,
    controller: conContra,
    obscureText: true, //Hace las letras con *
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, //Permite ajustar la imagen a todo el espacio
                image: AssetImage("images/fondo_wake.jpeg")
                )
        ),
        child: Stack( //Que es?
          alignment: Alignment.topCenter, //con esto el titulo apareceria en el centro
          children: [
            Positioned( //Permite crear un espacio donde todos elementos estaran en absolute, forzosamente antes debe de tener un stack
              top: 350,
              child: Opacity(
                opacity: .5,
                child: Container(
                  padding: EdgeInsets.all(10),//Margen a todo el container osea el formulario
                  decoration: BoxDecoration( //Investigar el Boxdecoration
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  height: 160,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ListView( //Si se conoce cuantos elementos seran se deja igual, sino se usa un .builder
                    //Se debe de envolver en un container para controlar su posicion
                    shrinkWrap: true,
                    children: [
                      textUser,
                      const SizedBox(height: 10,), //Es un espacio para dividir los elementos
                      pwdUser
                    ],
                  ),
                ),
              ),
            ),
            Image.asset("images/letrero_fondo.png"),
            Positioned(
              bottom: 50,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width*.9,
                child: ListView(
                shrinkWrap: true,
                children: [
                  SignInButton(
                    Buttons.Email,
                    onPressed: () {
                      /*setState(() { //Con esto se cambia el valor de is loading provocando lo de abajo
                        isloading = !isloading;
                      });*/
                      //Se cambiara esto para poder hacer el login
                      /*Future.delayed(new Duration(milliseconds: 5000), () {
                        //Al manejar rutas ya no se usa esto
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new DashBoardScreen()));*/
                          Navigator.pushNamed(context, "/onBoarding").then((value){ //Con esto podemos realizar una accion antes de cambiar de pantalla
                            setState(() {
                              isloading = !isloading;
                            });
                          });
                      });*/
                      //Tambien se debe de hacer esto para que tenga el mismo comportamiento del await

                      loginprovider.isLogued = true; //Esto provocara que se borre toda la pila de las pantalla y se vuelva a empezar de 0

                      authfirebase.signInUser(password: conContra.text, email: conEmail.text).then((value) {
                        //Esto aplicaria cuando no sea el login
                        if(!value){
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No se ha logueado correctamente", style: TextStyle(fontWeight: FontWeight.w400),)
                          )
                          );
                        }else{
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new DashBoardScreen()));
                          Navigator.pushNamed(context, "/onBoarding").then((value){ //Con esto podemos realizar una accion antes de cambiar de pantalla
                            setState(() {
                              isloading = !isloading;
                            });
                          });
                        }
                        
                      });
                    },
                    ),

                    SignInButton(
                    Buttons.Google,
                    onPressed: () {

                    },
                    ),

                    SignInButton(
                    Buttons.Facebook,
                    onPressed: () {},
                    ),

                    SignInButton(
                    Buttons.GitHub,
                    onPressed: () {},
                    ),

                    const SizedBox(height: 15,),

                    ElevatedButton.icon(
                      onPressed: (){
                        Navigator.pushNamed(context, '/registro');
                      },
                      icon: const Icon(Icons.app_registration, color: Colors.black,),
                      label: const Text("Register account", style: TextStyle(color: Colors.black),)
                    )
                ],
              )
              ),
            ),
            isloading ? const Positioned(
              top: 260,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ): Container()
          ],
        ),
      ),
    );
  }
}
