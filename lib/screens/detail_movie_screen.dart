import 'dart:ffi';

import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:psmn2/model/actor_movie_model.dart';
import 'package:psmn2/model/popular_model.dart';
import 'package:psmn2/model/reviews_movies_model.dart';
import 'package:psmn2/model/sesionUsu.dart';
import 'package:psmn2/network/api_popular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {

  final ApiPopular apiPopular = ApiPopular();
  late bool isFavorite;
  //String? sessionId = SessionUsu().getSessionId();
  //late PopularModel popularModelAppBar;
  //String? sessionId;

  @override
  Widget build(BuildContext context) {
    //final popularModel = ModalRoute.of(context)!.settings.arguments as PopularModel;
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final PopularModel popularModel = arguments['popularMovies'] as PopularModel;
    final List<ActorsMovieModel> actors = arguments['actors'];
    final List<ReviewsMovieModel> reviews = arguments['reviews'];
    //popularModelAppBar=popularModel;
    isFavorite = arguments['isFavorite'];
    String? sessionId = SessionUsu().getSessionId();
     /*return Center(
      child: Text(popularModel.title!),
    );*/
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            if(isFavorite){
              apiPopular.deleteFavoriteMovie(popularModel.id!, sessionId!).then((value){
                if(value){
                  var snackbar = SnackBar(content: Text("Se ha eliminado de favoritos"));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }else{
                  var snackbar = SnackBar(content: Text("No se ha podido quitar de favoritos"));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              });
            }else{
              apiPopular.addFavoriteMovie(popularModel.id!, sessionId!).then((value){
                if(value){
                  var snackbar = SnackBar(content: Text("Se ha agregado a favoritos"));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }else{
                  var snackbar = SnackBar(content: Text("Ya se ha agregado a favoritos"));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              });
            }
          },
          icon: Icon(Icons.favorite))
        ],
      ),
      body: /*ScaffoldLayoutBuilder(
      backgroundColorAppBar:
          const ColorBuilder(Colors.transparent, Color.fromARGB(255, 114, 186, 245)),
      textColorAppBar: const ColorBuilder(Colors.white),
      appBarBuilder: _appBar,
        child: */ Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://image.tmdb.org/t/p/w500/${popularModel.posterPath}"),
                opacity: 0.2
            )
          ),
          child: ListView(
            children: [
              Text(popularModel.title.toString(), textAlign: TextAlign.center, style: TextStyle(
                fontSize: 25, fontFamily: 'RocknRoll'
              ),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: apiPopular.getTrailer(popularModel.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return YoutubePlayer(
                        controller: YoutubePlayerController(
                            initialVideoId: snapshot.data.toString(),
                            flags: const YoutubePlayerFlags(
                              autoPlay: true,
                              mute: true,
                            )),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Popularidad",style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RocknRoll'
                ),),
              ),
              RatingBar(
                initialRating: popularModel.voteAverage!/2,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star,
                      color: Colors.amber
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: Colors.amber,
                    )),
                ignoreGestures: true,
                onRatingUpdate: (value) {},
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  popularModel.overview.toString(), textAlign: TextAlign.justify, style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'RocknRoll'
                  ),
                ),
              ),
              SizedBox(height: 10,),
              const Text(
              " Actores de la pelicula:",
              style: TextStyle(
                  fontSize: 25, color: Colors.black, fontFamily: 'RocknRoll'),
            ),
              Container(
                      height: 220, // Altura deseada del ListView
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: actors.length,
                        itemBuilder: (context, index) {
                          final actor = actors[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8), // Opcional: puedes ajustar el radio de las esquinas si lo deseas
                                    child: Image.network(
                                      actor.profilePath.isNotEmpty 
                                        ? 'https://image.tmdb.org/t/p/w500/${actor.profilePath}'
                                        : "https://upload.wikimedia.org/wikipedia/commons/4/40/Usuario_anonimo.PNG", //URL generica
                                      width: 100, // Ancho deseado de la imagen
                                      height: 120, // Altura deseada de la imagen
                                      fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el espacio disponible
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 80),
                                      Text(
                                  actor.name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'RocknRoll'),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  actor.character, 
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontFamily: 'RocknRoll'),
                                ),
                                    ]
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: 10,),
              const Text(
              " Opiniones de los usuarios:",
              style: TextStyle(
                  fontSize: 25, color: Colors.black, fontFamily: 'RocknRoll'),
            ),
            SizedBox(height: 20,),
              Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: reviews.length,
                  itemBuilder: (context, index){
                    final review = reviews[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.autor, 
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'RocknRoll'),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            review.contenido,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'RocknRoll'),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ]
          ),
        ),
    );
  }
}