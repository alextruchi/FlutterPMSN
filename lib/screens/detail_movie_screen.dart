import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:psmn2/model/popular_model.dart';
import 'package:psmn2/network/api_popular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {

  final ApiPopular apiPopular = ApiPopular();

  @override
  Widget build(BuildContext context) {
    final popularModel = ModalRoute.of(context)!.settings.arguments as PopularModel;
     /*return Center(
      child: Text(popularModel.title!),
    );*/
    return Scaffold(
      body: Container(
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
          ],
        ),
      ),
    );
  }
}