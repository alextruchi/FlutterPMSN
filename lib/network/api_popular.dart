import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:psmn2/model/popular_model.dart';

class ApiPopular{
  final dio = Dio();
  final Url = "https://api.themoviedb.org/3/movie/popular?api_key=b1b32b60793726c09330dd64adff713d&language=es-MX&page=1";

  Future<List<PopularModel>?> getPopularMovie() async{ //Todo lo que involucre cosas asincronas se debe de usar future.
    Response response = await dio.get(Url); //Si fuera con una uri se tendria que parsear
    
    if(response.statusCode == 200){

      //print(response.data['results'].runtimeType); Comprueba si hay cosas en el response y el runtimeType dice de que tipo es lo recibido

      final listMovies = response.data['results'] as List; //Con este parseo se obtiene los elementos de la respuesta ya que no esta directo en el data
      return listMovies.map((movie) => PopularModel.fromMap(movie)).toList();// Quitamos el jsonDecode porque ya regresaba una lista tal cual y no era necesario
    }
    return null;
  }

  Future<String> getTrailer(int id) async {
    final Url =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=b1b32b60793726c09330dd64adff713d';
    Response response = await dio.get(Url);

    if(response.statusCode == 200){
      final trailer = response.data['results'] as List;
      for (final element in trailer) {
        if (element['type'] == 'Trailer') {
          return element['key'];
        }
      }
    }
    return '';
  }
}