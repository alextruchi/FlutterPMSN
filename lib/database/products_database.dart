import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:psmn2/model/products_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsDatabase {
  static final NAMEDB = 'DESPENSADB';
  static final VERSIONDB = 1;
  
  static Database? _database;//El guion bajo significa que es privado

  Future<Database> get database async {//Siempre se tendra que mandar a llamar para abrir la conexion, si ya esta abierta pues ya solamente se vuelve a llamar en vez de crear.
    if(_database != null ) return _database!; //Con esto se asegura que sea diferente de null
    return _database = await _initDatabase(); //Como este es algo futuro todo tiene que ser async
  }

  Future<Database> _initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory(); //Como es un future directory se usa el await
    String pathDB = join(folder.path,NAMEDB);
    return openDatabase(//Este metodo es el que crea toda la base de datos de acuerdo a la version indicada sino no se conectará
      pathDB,
      version: VERSIONDB,
      onCreate:(db, version) {//Al usar integer y primary se crea un autoincrementable
        String query = '''create table tblProductos(
          idProducto integer primary key, 
          nomProducto varchar(30),
          cantProducto integer,
          fechaCaducidad varchar(10)
        )''';
        db.execute(query);
      },
    );
  }

  //Todo lo que pueda tardar un poco mas, se recomienda hacer un future
  //En insertar se busca el ultimo id que se inserto, el actu y eli se busca la cantidad de filas afectadas y la consulta no se sabe
  Future<int> insertar(Map<String, dynamic> data) async {
    final conexion = await database;
    return conexion.insert('tblProductos',data);
  }

  Future<int> actualizar(Map<String, dynamic> data) async{
    final conexion = await database;
    return conexion.update(
      'tblProductos',
      data,
      where: 'idProducto = ?',
      whereArgs: [data['idProducto']],
    );
  }

  Future<int> eliminar(int idProducto) async{
    final conexion = await database;
    return conexion.delete(
      'tblProductos',
      where: 'idProducto = ?',
      whereArgs: [idProducto],
    );
  }

  Future<List<ProductosModel>> consultar() async{
    final conexion =  await database;
    var products = await conexion.query('tblProductos'); //Se debe de usar el await para esperar a que products ahora si ya tenga las cosas
    return products.map((product) => ProductosModel.fromMap(product)).toList(); //Si se quisiera hacer mas en el query se declara una variable asignandole esta linea y ahi aplicar metodos como el where
  }
}