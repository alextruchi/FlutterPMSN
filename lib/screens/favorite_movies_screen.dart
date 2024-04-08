
import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:animated_flutter_widgets/animated_widgets/scroll_widget/animated_gridview_builder.dart';
import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:flutter/material.dart';
import 'package:psmn2/model/popular_model.dart';
import 'package:psmn2/model/sesionUsu.dart';
import 'package:psmn2/network/api_popular.dart';
import 'package:psmn2/screens/detail_movie_screen.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {

  ApiPopular? apiPopular;
  bool? isFavorite = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiPopular = ApiPopular();
    });
  }

  @override
  Widget build(BuildContext context) {
     //String? sessionId = SessionUsu().getSessionId();
     //String? sessionId = apiPopular!.getSessionId().toString();
     //final arguments = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
     String? sessionId = SessionUsu().getSessionId();

    return Scaffold(
      appBar: /*AppBar(
        title: Text("Peliculas favoritas"),
      ),*/
      SlideInAnimatedAppBar(
        backgroundColor: Colors.orange,
        animationDuration: 1000,
        title: const Text('Peliculas favoritas'),
      ),
      body: FutureBuilder(
          future: apiPopular!.getFavoriteMovies(sessionId!),
          builder: (context,AsyncSnapshot<List<PopularModel>?> snapshot){ //El snapshot trae cada elemento del arreglo (Es una lista del popular model)
            if (snapshot.hasData) {
              return AnimatedGridViewBuilder(//Se puede poner un .builder a un contenedor cuando no se cauntos elementos hay
                itemCount: snapshot.data!.length, //Le indica la cantidad de elementos a mostrar para que no de error mostrando muchas cosas
                animationType: ScrollWidgetAnimationType.leftScale,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //El numero de columnas a mostrar
                  childAspectRatio: .7, //Se recomienda dejarlo bajo
                  mainAxisSpacing: 10, //La separacion de cada elemento
                ), 
                itemBuilder: (context,index){
                  return GestureDetector( //Se usa para poder darle un evento a un widgets que no tenga ontap
                    onTap: () async{
                      final actors = await apiPopular!.getMovieActors(snapshot.data![index].id!);
                      final reviews = await apiPopular!.getReviewsMovies(snapshot.data![index].id!);
                      //Navigator.pushNamed(context, "/detail", arguments: {'popularMovies': snapshot.data![index], 'isFavorite': isFavorite, 'actors': actors, 'reviews': reviews});
                      Navigator.push(context, FlippingRotationTransition(isReversed: false, page: DetailMovieScreen(actors: actors, reviews: reviews, isFavorite: isFavorite, modelo: snapshot.data![index],)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage(// Aplica un efecto de difuminado
                        placeholder: const AssetImage("images/loading.gif"),
                        image: NetworkImage("https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}"),
                      ),
                    ),
                  );
                },
              );
            }else{
              if(snapshot.hasError){
                return const Center(child: Text("Ocurrio un error..."),);
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            }
          },
        ),
    );
  }
  
}