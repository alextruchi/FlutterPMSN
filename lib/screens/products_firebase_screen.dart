import 'package:flutter/material.dart';
import 'package:psmn2/services/products_firebase.dart';

class ProductsFirebaseScreen extends StatefulWidget {
  const ProductsFirebaseScreen({super.key});

  @override
  State<ProductsFirebaseScreen> createState() => _ProductsFirebaseScreenState();
}

class _ProductsFirebaseScreenState extends State<ProductsFirebaseScreen> {

  final productsFirebase = ProductsFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos de firebase"),
      ),
      body: StreamBuilder(
        stream: productsFirebase.consultar(), //Esto hace que nos suscribamos a la coleccion, cuando ocurra un cambio, se actualizará todo automaticamente
        builder:(context, snapshot) {
          if(snapshot.hasData){
            ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index) {
                return Image.network(snapshot.data!.docs[index].get('imagen'));
              },
            );
          }else{
            if(snapshot.hasError){
              return Text("Error al obtener datos");
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
        }, 
      ),
    );
  }
}