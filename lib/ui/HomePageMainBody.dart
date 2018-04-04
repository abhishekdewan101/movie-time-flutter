import 'package:flutter/material.dart';
import 'package:movietime_app/network/NetworkManger.dart';
import 'package:movietime_app/network/Configs.dart';

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
      initialPage: mCurrentPage,
      keepPage: false,
      viewportFraction: 0.7
    );
    mMovieData = new List<Movie>();
    mNetworkManager = new NetworkManager();
    mNetworkManager.getMovieData(dataPagination).then((movieData){
      setState((){
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
      padding: new EdgeInsets.only(top: 50.0),
//      decoration: new BoxDecoration(
//        color: Colors.blueAccent,
//      ),
      child: new PageView.builder(
          itemBuilder: (context,index){return itemBuilder(context, index);},
        controller: mPageController,
        physics: new AlwaysScrollableScrollPhysics(),
        itemCount: mMovieData.length,
        onPageChanged: (value){
            setState((){
              mCurrentPage = value;
              print(value > (mMovieData.length - threshold));
              if (value > (mMovieData.length - threshold)) {
                dataPagination++;
                loadMoreData();
              }
            });
        },
      )
    );
  }

  void loadMoreData() {
    mNetworkManager.getMovieData(dataPagination).then((movie){
      setState((){
        mMovieData.addAll(movie);
      });
    });
  }



  Widget itemBuilder(BuildContext context, int index) {
    return new AnimatedBuilder(
      animation: mPageController,
      builder: (context, child) {
        double value = mPageController.page - index;
        value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);

        return new Center(
          child: new SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            width: Curves.easeOut.transform(value) * 250,
            child: child,
          ),
        );
      },
      child: new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Image.network(Configs.IMAGE_URL + mMovieData[index].mPosterUrl),
      ),
    );
  }
}