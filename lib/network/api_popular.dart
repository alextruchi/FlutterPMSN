import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:psmn2/model/actor_movie_model.dart';
import 'package:psmn2/model/popular_model.dart';
import 'package:psmn2/model/reviews_movies_model.dart';
import 'package:psmn2/model/sesionUsu.dart';
import 'package:http/http.dart' as http;

class ApiPopular{
  final dio = Dio();
  
  final Url = "https://api.themoviedb.org/3/movie/popular?api_key=b1b32b60793726c09330dd64adff713d&language=es-MX&page=1";
  final usuario = "alextruchi";
  final contra = "drilloid45est";
  String? sessionId;

  SessionUsu sessionManager = SessionUsu();
  

  Future<List<PopularModel>?> getPopularMovie() async{ //Todo lo que involucre cosas asincronas se debe de usar future.
    Response response = await dio.get(Url); //Si fuera con una uri se tendria que parsear
    
    if(response.statusCode == 200){

      //print(response.data['results'].runtimeType); Comprueba si hay cosas en el response y el runtimeType dice de que tipo es lo recibido

      final listMovies = response.data['results'] as List; //Con este parseo se obtiene los elementos de la respuesta que sean results ya que no esta directo en el data que obtuvimos
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

  Future<bool> addFavoriteMovie(int id, String idSession) async{
    final urlFavorites = "https://api.themoviedb.org/3/account/21058333/favorite?api_key=b1b32b60793726c09330dd64adff713d&session_id=$idSession";
    try {
      final response = await dio.post(urlFavorites,
        data: {
          "media_type": "movie",
          "media_id": id.toString(),
          "favorite": true, // Aqui se agrega
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
    }
    return false;
  }

  Future<bool> deleteFavoriteMovie(int id, String idSession) async{
    final urlFavorites = "https://api.themoviedb.org/3/account/21058333/favorite?api_key=b1b32b60793726c09330dd64adff713d&session_id=$idSession";
    
    try {
      final response = await dio.post(urlFavorites,
        data: {
          "media_type": "movie",
          "media_id": id.toString(),
          "favorite": false, // Aqui se agrega
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
    }
    return false;
  }

  Future<List<PopularModel>?> getFavoriteMovies(String idSession) async {
    final urlFavorites = "https://api.themoviedb.org/3/account/21058333/favorite/movies?api_key=b1b32b60793726c09330dd64adff713d&session_id=$idSession";

      final response = await dio.get(urlFavorites);
      if (response.statusCode == 200) {
        final listMovies = response.data['results'] as List;
        return listMovies.map((movie) => PopularModel.fromMap(movie)).toList();
      }
      //print("No se obtuvo las peliculas favoritas");
      return null;
  }

  Future<void> getSessionId() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/authentication/token/new?api_key=b1b32b60793726c09330dd64adff713d'));
    final tokenJson = json.decode(response.body);
    final String requestToken = tokenJson['request_token'];
    //print(response.statusCode);

    final responseLogin = await http.post(
      Uri.parse('https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=b1b32b60793726c09330dd64adff713d'),
      body: {
        'username': usuario,
        'password': contra,
        'request_token': requestToken,
      },
    );

    //print(responseLogin.statusCode);
    final loginJson = json.decode(responseLogin.body);
    final bool? loginSuccess = loginJson['success'];

    if (loginSuccess == true) {
      final responseSession = await http.post(
        Uri.parse('https://api.themoviedb.org/3/authentication/session/new?api_key=b1b32b60793726c09330dd64adff713d'),
        body: {
          'request_token': requestToken,
        },
      );
      final sessionJson = json.decode(responseSession.body);
      sessionId = sessionJson['session_id'];
      sessionManager.setSessionId(sessionId!);
    }else{
      //print("No entro al login success");
    }
  }

  Future<List<ActorsMovieModel>?> getMovieActors(int id) async{
    final UrlActors = 'https://api.themoviedb.org/3/movie/${id.toString()}/credits?api_key=b1b32b60793726c09330dd64adff713d&language=es-MX';
    Response response = await dio.get(UrlActors);
    
    if (response.statusCode == 200) {
      final listActors = response.data['cast'] as List;
      return listActors.map((actors) => ActorsMovieModel.fromMap(actors)).toList();
    }
    return null;
  }

  Future<List<ReviewsMovieModel>?> getReviewsMovies(int id)async{
    final urlReviews = 'https://api.themoviedb.org/3/movie/${id}/reviews?api_key=b1b32b60793726c09330dd64adff713d';
    Response response = await dio.get(urlReviews);

    if(response.statusCode==200){
      final reviews = response.data['results'] as List;
      return reviews.map((reviews) => ReviewsMovieModel.fromMap(reviews)).toList();   
    }
  }
}