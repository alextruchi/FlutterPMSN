import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:psmn2/model/popular_model.dart';

class ApiPopular{
  final dio = Dio();
  final Url = "https://api.themoviedb.org/3/movie/popular?api_key=ff24b7bbb0fc4a4369dcb8cd87fa1f48&language=es-MX&page=1";

  Future<List<PopularModel>?> getPopularMovie() async{ //Todo lo que involucre cosas asincronas se debe de usar future.
    Response response = await dio.get(Url); //Si fuera con una uri se tendria que parsear
    if(response.statusCode == 200){
      final listMovies = jsonDecode(response.data)['results'] as List; //Con este parseo se obtiene los elementos de la respuesta ya que no esta directo en el data
      return listMovies.map((movie) => PopularModel.fromMap(movie)).toList();
    }
    return null;
  }
}