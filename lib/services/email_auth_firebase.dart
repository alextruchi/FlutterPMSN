import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthFirebase {
  final firebaseAuth = FirebaseAuth.instance; //Objeto que hace referencia a firebaseauth


  //Metodo para registrar usuarios
  Future<bool> signUpUser ({required name, required String password, required String email}) async{
    //Required obliga a que se necesiten los parametros
    try{
      final credenciales = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(credenciales.user!=null){
        credenciales.user!.sendEmailVerification();
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }

  //Por ahora es por si todo esta bien con las credenciales y no se equivoca el usuario
  Future<bool> signInUser({required name, required String password, required String email}) async{
    bool bandera=false;
    try{
      final credenciales = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(credenciales.user!=null){ //Verificacion de que si existe en la base de datos
        if(credenciales.user!.emailVerified){
          bandera=true;
        }
      }
    }catch(e){
      
    }
    return bandera;
  }
}