import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:psmn2/database/products_database.dart';
import 'package:psmn2/model/products_model.dart';
import 'package:intl/intl.dart';
import 'package:psmn2/settings/app_value_notifier.dart';

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
        title: const Text("Mi despensa "),
        //Barra de navegacion de la derecha
        actions: [
          IconButton(
            onPressed: () {
              _showModal(context, null);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      //El builder siempre trae un widget, y el futuro permite interactuar con cosas future
      body: ValueListenableBuilder(//Este builder Crea cosas dependiendo de los valores declarados en app_value_notifier
        valueListenable: AppValueNotifiier.banProducts,
        builder: (context,value,_) {
          return FutureBuilder(
            future: productsDB!
                .consultar(), //Da error sino le ponemos un ! porque lo detecta como nulo antes de ejecutarlo, siempre se deben de hacer estas validaciones para que funcione sino siempre fallará
            builder: (context, AsyncSnapshot<List<ProductosModel>> snapshot) {
              //Regresa una lista de objetos
              if (snapshot.hasError) {
                return Center(
                  child: Text("Algo salio mal obteniendo datos..."),
                );
              } else {
                if (snapshot.hasData) {
                    //Aqui ira la lista de las cosas
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          return itemDespensa(snapshot.data![index]);
                        }
                      ),
                    );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            },
          );
        }
      ),
    );
  }

  Widget itemDespensa(ProductosModel productos){
    return Container(
      margin: EdgeInsets.only(top: 10), //Con esto se separa todo lo de aqui agregando un espacio arriba
      height: 100,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        children: [
          Text('${productos.nomProducto!}'),
          Text('${productos.fechaCaducidad!}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  _showModal(context, productos);
                  
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  //_showModal();
                  ArtDialogResponse response = await ArtSweetAlert.show(
                      barrierDismissible: false,
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                        denyButtonText: "Cancel",
                        title: "Are you sure?",
                        text: "You won't be able to revert this!",
                        confirmButtonText: "Yes, delete it",
                        type: ArtSweetAlertType.warning
                      )
                  );

                  if (response == null) {
                    return;
                  }

                  if (response.isTapConfirmButton) {
                    productsDB!.eliminar(productos.idProducto!).then((value){
                      if(value>0){
                        ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: "Se elimino correctamente!"));
                        AppValueNotifiier.banProducts.value = !AppValueNotifiier.banProducts.value;//Vuelve a reconstruir el builder con su cambio de valor
                      }else{

                      }
                    });
                    /*ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: "Deleted!"));*/

                    
                    return;
                  }
                },
                icon: Icon(Icons.delete),
                
              )
            ],
          )
        ],
      ),
    );
  }

//Este metodo servirá para diferentes botones (crear, editar), es por eso que los textos que se ocupan se declaran aqui
  _showModal(context, ProductosModel? producto){
    final conNombre = TextEditingController(); //Controlador de la caja de texto
    final conCantidad = TextEditingController();
    final conFecha = TextEditingController();

    if (producto!=null){ //Esto es cuando si se reciben datos cuando le demos clic a editar
      conNombre.text = producto.nomProducto!;
      conCantidad.text = producto.cantProducto!.toString();
      conFecha.text = producto.fechaCaducidad!;
    }

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
        if (producto == null) {
          productsDB!.insertar({
            "nomProducto": conNombre.text,
            "cantProducto": int.parse(conCantidad.text),
            "fechaCaducidad": conFecha.text,
          }).then((value) {
            Navigator.pop(context);
            String msj = "";
            if (value > 0) {
              //Importante no poner el ! hasta el final sino no vuelve a renderizar en el builder
              AppValueNotifiier.banProducts.value =
                  !AppValueNotifiier.banProducts.value;
              msj = "Producto insertado";
            } else {
              msj = "Ocurrio un error...";
            }
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          });
        }else{
          productsDB!.actualizar({
            "idProducto" : producto.idProducto,
            "nomProducto": conNombre.text,
            "cantProducto": int.parse(conCantidad.text),
            "fechaCaducidad": conFecha.text,
        }).then((value) {
          Navigator.pop(context);
            String msj = "";
            if (value > 0) {
              //Importante no poner el ! hasta el final sino no vuelve a renderizar en el builder
              AppValueNotifiier.banProducts.value = !AppValueNotifiier.banProducts.value;
              msj = "Producto actualizado";
            } else {
              msj = "Ocurrio un error...";
            }
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }
        
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
