import 'package:flutter/material.dart';
import 'package:psmn2/model/popular_model.dart';
import 'package:psmn2/network/api_popular.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  
  ApiPopular? apiPopular;
  bool? isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Inicializa antes de todo
    apiPopular = ApiPopular();
    
  }
  
  @override
  Widget build(BuildContext context) {
    //Future<String?> sessionId = apiPopular!.getSessionId();
    //print(sessionId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas populares"),
        actions: [IconButton(
          onPressed: (){
            Navigator.pushNamed(context, "/favorites");
          },
          icon: Icon(Icons.favorite),
        ),
          ],
      ),
      body: FutureBuilder(
        future: apiPopular!.getPopularMovie(),
        builder: (context,AsyncSnapshot<List<PopularModel>?> snapshot){ //El snapshot trae cada elemento del arreglo (Es una lista del popular model)
          if (snapshot.hasData) {
            return GridView.builder(//Se puede poner un .builder a un contenedor cuando no se cauntos elementos hay
              itemCount: snapshot.data!.length, //Le indica la cantidad de elementos a mostrar para que no de error mostrando muchas cosas
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //El numero de columnas a mostrar
                childAspectRatio: .7, //Se recomienda dejarlo bajo
                mainAxisSpacing: 10, //La separacion de cada elemento
              ), 
              itemBuilder: (context,index){
                return GestureDetector( //Se usa para poder darle un evento a un widgets que no tenga ontap
                  onTap: () async {
                    final actors = await apiPopular!.getMovieActors(snapshot.data![index].id!);
                    final reviews = await apiPopular!.getReviewsMovies(snapshot.data![index].id!);
                    Navigator.pushNamed(context, "/detail", arguments: {'popularMovies': snapshot.data![index], 'isFavorite': isFavorite, 'actors':actors, 'reviews': reviews});
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