import 'package:flutter/material.dart';
import 'package:psmn2/database/products_database.dart';
import 'package:psmn2/model/products_model.dart';

class DespensaScreen extends StatefulWidget {
  const DespensaScreen({super.key});

  @override
  State<DespensaScreen> createState() => _DespensaScreenState();
}

class _DespensaScreenState extends State<DespensaScreen> {

  ProductsDatabase? productsDB;

  //Con el signo de interrogacion es nulo, si se pone late antes de la variable eso no es nulo

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsDB = new ProductsDatabase();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi despensa: "),
        //Barra de navegacion de la derecha
        actions: [
          IconButton(
            onPressed:() {
            
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      //El builder siempre trae un widget, y el futuro permite interactuar con cosas future
      body: FutureBuilder(
        future: productsDB!.consultar(), //Da error sino le ponemos un ! porque lo detecta como nulo antes de ejecutarlo, siempre se deben de hacer estas validaciones para que funcione sino siempre fallará
        builder: (context, AsyncSnapshot<List<ProductosModel>> snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Algo salio mal obteniendo datos..."),);
          }else{
            if(snapshot.hasData){
              return Container(
                //Aqui ira la lista de las cosas
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}