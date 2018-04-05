import 'package:flutter/material.dart';
import 'package:movietime_app/network/Configs.dart';
import 'package:movietime_app/network/NetworkManger.dart';

class MovieDetail extends StatefulWidget {
  Movie mMovie;
  MovieDetail(this.mMovie);

  @override
  State<StatefulWidget> createState() => new MovieDetailState(mMovie);

}

class MovieDetailState extends State<MovieDetail> {

  Movie mMovie;

  MovieDetailState(this.mMovie);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return new Stack(
      children: <Widget>[
        buildBottomMovieDetail(mMovie,context),
        buildTopMovieDetail(mMovie,context),
      ],
    );
  }

  Widget buildBottomMovieDetail(Movie movie, BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: new EdgeInsets.fromLTRB(15.0, MediaQuery.of(context).size.height - 700.0, 15.0, 10.0),
      child: new Material(
        borderRadius: new BorderRadius.only(
          topRight: new Radius.circular(20.0),
          topLeft: new Radius.circular(20.0),
          bottomLeft: new Radius.circular(20.0),
          bottomRight: new Radius.circular(20.0)
        ),
        color: Colors.white,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(0.0, 230.0, 0.0, 0.0),
          padding: new EdgeInsets.only(left: 20.0,right: 20.0),
          child: new Column(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: new Text(
                  movie.mTitle,
                  style: new TextStyle(
                    fontSize: 28.0,
                    fontFamily: "Roboto"
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(top: 10.0),
                child: new SingleChildScrollView(
                  child: new Text(
                      movie.mDescription,
                      style: new TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Roboto"
                  ),
                )
              )
            ),
          ]
        )
      ),
     )
    );
  }

  Widget buildTopMovieDetail(Movie movie, BuildContext context) {
    return new Container(
      margin: new EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      child: new Align(
        alignment: Alignment.topLeft,
        child: new Material(
          borderRadius: new BorderRadius.circular(20.0),
          child: new Image.network(
              Configs.IMAGE_URL + movie.mPosterUrl,
            height: MediaQuery.of(context).size.height - 500,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        )
      ),
    );
  }

}