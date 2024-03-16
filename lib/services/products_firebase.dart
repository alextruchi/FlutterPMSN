import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsFirebase{
  final fireStore = FirebaseFirestore.instance;

  CollectionReference? _productsCollection;

  ProductsFirebase(){
    _productsCollection = fireStore.collection('productos');
  }

  Stream<QuerySnapshot> consultar(){
    //Cuando se trbajan con servicios en la nube, lo normal es suscribirse a un grupo, en este caso nos suscribimos en la coleccion
    //Como este no es futuro, no lleva async
    return _productsCollection!.snapshots(); //Con esto nos traemos TODOS los resultados de nuestra BD.
    //si le ponemos al final .contains es como un like
  }

  Future<void> insertar(Map<String, dynamic> data) async{
    //Aqui si lo dejamos vacio los id se haran de forma automatica sino si lo podemos personalizar
    return _productsCollection!.doc().set(data);
  }

  Future<void> actualizar(Map<String, dynamic> data, String id) async{
    return _productsCollection!.doc(id).update(data);
  }

  //Este es el id del documento (registro)
  Future<void> borrar(String id) async{
    _productsCollection!.doc(id).delete();
  }
}