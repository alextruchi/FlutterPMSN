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
  Future<bool> signInUser({required String password, required String email}) async{
    var band = false;
    final UserCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (UserCredential.user != null) {
      if (UserCredential.user!.emailVerified) {
        band = true;
      }
    }
    return band;

  }
}