import 'package:flutter/material.dart';
import 'package:movietime_app/network/NetworkManger.dart';
import 'package:movietime_app/network/Configs.dart';
import 'package:movietime_app/ui/MovieDetail.dart';

class HomePageMainBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageMainBodyState();
}

class HomePageMainBodyState extends State<HomePageMainBody> {
  PageController mPageController;
  int mCurrentPage = 0;
  int dataPagination = 1;
  int threshold = 5;
  NetworkManager mNetworkManager;
  List<Movie> mMovieData;

  @override
  void initState() {
    super.initState();
    mPageController = new PageController(
        initialPage: mCurrentPage, keepPage: false, viewportFraction: 1.0);
    mMovieData = new List<Movie>();
    mNetworkManager = new NetworkManager();
    mNetworkManager.getMovieData(dataPagination).then((movieData) {
      setState(() {
        mMovieData.addAll(movieData);
      });
    });
  }

  @override
  void dispose() {
    mPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Current Page is" + mCurrentPage.toString());

    return new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Stack(
          children: <Widget>[
//          new Opacity(
//            opacity: 0.3,
//                child: new Image.network(
//                    Configs.IMAGE_URL + mMovieData[mCurrentPage].mBackdropUrl,
//                    width: MediaQuery.of(context).size.width,
//                    height: MediaQuery.of(context).size.height,
//                    fit: BoxFit.cover
//                )
//            ),
            new Opacity(
                  opacity: 0.6,
                  child: new Container(
                      color:Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                  )
            ),
            new PageView.builder(
              itemBuilder: (context, index) {
                return itemBuilder(context, index);
              },
              controller: mPageController,
              physics: new AlwaysScrollableScrollPhysics(),
              itemCount: mMovieData.length,
              onPageChanged: (value) {
                setState(() {
                  mCurrentPage = value;
                  print(value > (mMovieData.length - threshold));
                  if (value > (mMovieData.length - threshold)) {
                    dataPagination++;
                    loadMoreData();
                  }
                });
              }
            )
          ],
        ),
    );
  }

  void loadMoreData() {
    mNetworkManager.getMovieData(dataPagination).then((movie) {
      setState(() {
        mMovieData.addAll(movie);
      });
    });
  }

  Widget itemBuilder(BuildContext context, int index) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return new MovieDetail(mMovieData[index]);
  }

}
