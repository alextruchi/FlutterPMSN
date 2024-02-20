import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:psmn2/screens/dashboard_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  
  bool isloading = false;

  final textUser = TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );

  final pwdUser = TextField(
    keyboardType: TextInputType.text,
    obscureText: true, //Hace las letras con *
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );


  @override
  Widget build(BuildContext context) {
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
          alignment: Alignment.center, //con esto el titulo apareceria en el centro
          children: [
            Positioned( //Permite crear un espacio donde todos elementos estaran en absolute, forzosamente antes debe de tener un stack
              top: 500,
              child: Opacity(
                opacity: .5,
                child: Container(
                  padding: EdgeInsets.all(10),//Margen a todo el container osea el formulario
                  decoration: BoxDecoration( //Investigar el Boxdecoration
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  height: 130,
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
              bottom: 10,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width*.9,
                child: ListView(
                shrinkWrap: true,
                children: [
                  SignInButton(
                    Buttons.Email,
                    onPressed: () {
                      setState(() { //Con esto se cambia el valor de is loading provocando lo de abajo
                        isloading = !isloading;
                      });
                      Future.delayed(new Duration(milliseconds: 5000), () {
                        //Al manejar rutas ya no se usa esto
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new DashBoardScreen()));*/
                          Navigator.pushNamed(context, "/dash").then((value){ //Con esto podemos realizar una accion antes de cambiar de pantalla
                            setState(() {
                              isloading = !isloading;
                            });
                          });
                      });
                    },
                    ),

                    SignInButton(
                    Buttons.Google,
                    onPressed: () {},
                    ),

                    SignInButton(
                    Buttons.Facebook,
                    onPressed: () {},
                    ),

                    SignInButton(
                    Buttons.GitHub,
                    onPressed: () {},
                    ),
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
