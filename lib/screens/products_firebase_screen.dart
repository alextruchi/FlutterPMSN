import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.store),
        onPressed:() => showModal(context)
      ),
      appBar: AppBar(
        title: const Text("Productos de firebase"),
      ),
      body: StreamBuilder(
        stream: productsFirebase.consultar(), //Esto hace que nos suscribamos a la coleccion, cuando ocurra un cambio, se actualizará todo automaticamente
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index) {
                return Image.network(snapshot.data!.docs[index].get('imagen'));
              },
            );
          }else{
            if(snapshot.hasError){
              return const Text("Error al obtener datos");
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }
        }, 
      ),
    );
  }

  showModal(context){
    final conNombre = TextEditingController(); //Controlador de la caja de texto
    final conCantidad = TextEditingController();
    final conFecha = TextEditingController();

    final txtNombre = TextFormField(
        keyboardType: TextInputType.text,
        controller: conNombre,
        decoration: const InputDecoration(border: OutlineInputBorder()));

    final txtCantidad = TextFormField(
        keyboardType: TextInputType.number,
        controller: conCantidad,
        decoration: const InputDecoration(border: OutlineInputBorder()));

    final txtFecha = TextFormField(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(
              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

          setState(() {
            conFecha.text =
                formattedDate; //set foratted date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
      controller: conFecha,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    final btnAgregar = ElevatedButton.icon(
      onPressed: () {
        productsFirebase.insertar({
          'nomProducto': conNombre.text,
          'cantProducto': conCantidad.text,
          'fechaCaducidad': conFecha.text,
          'imagen': 'https://www.soriana.com/dw/image/v2/BGBD_PRD/on/demandware.static/-/Sites-soriana-grocery-master-catalog/default/dw931c9e97/images/product/0041789001864_A.jpg?sw=445&sh=445&sm=fit'
        });

      },
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );

    final space = SizedBox(
      height: 10,
    );

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              txtNombre,
              space,
              txtCantidad,
              space,
              txtFecha,
              space,
              btnAgregar,
            ],
          );
        }
    );
  }
}