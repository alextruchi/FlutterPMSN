class ProductosModel{
  int? idProducto;
  String? nomProducto;
  int? cantProducto;
  String? fechaCaducidad;

  ProductosModel({
    this.idProducto,
    this.cantProducto,
    this.fechaCaducidad,
    this.nomProducto,
  });

  //
  factory ProductosModel.fromMap(Map<String, dynamic> producto){
    return ProductosModel(
      idProducto: producto['idProducto'],
      nomProducto: producto['nomProducto'],
      cantProducto: producto['cantProducto'],
      fechaCaducidad: producto['fechaCaducidad'],
    );
  }
}