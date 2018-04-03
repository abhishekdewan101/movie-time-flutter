import 'package:flutter/material.dart';

class HomePageTopBar extends StatelessWidget {

  final String mTitle;
  final double mBarHeight = 66.0;

  bool mSearchBarStatus = false;

  HomePageTopBar(this.mTitle);

  @override
  Widget build(BuildContext context) {
    
    final double mStatusBarHeight = MediaQuery.of(context).padding.top;
    
     return new Container(
       height: mBarHeight + mStatusBarHeight,
       padding: new EdgeInsets.only(top:mStatusBarHeight),
       decoration: new BoxDecoration(
         gradient: new LinearGradient(
           colors: [
             const Color(0xFF3366FF),
             const Color(0xFF00CCFF)
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
         )
       ),
       child: getAppBarChild()
     );
  }

  Widget getAppBarChild() {
    if (mSearchBarStatus) {
      return createSearchStatusBar();
    } else {
      return createNormalStatusBar();
    }
  }

  TextEditingController mMovieSearchController = new TextEditingController();

  Widget createSearchStatusBar() {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child:  new TextField(
              controller: mMovieSearchController,
              decoration: new InputDecoration(
                hintText: 'Type something',
                fillColor: Colors.white
              ),
            ),
          )
        )
      ],
    );
  }
  
  Widget createNormalStatusBar(){
    return new Stack(
         children: <Widget>[
           new Align(
             alignment: Alignment.center,
             child: new Text(
               mTitle,
               style: new TextStyle(
                 fontFamily: "Roboto-Thin",
                 fontSize: 32.0,
                 color: Colors.white
               )),
           ),
           new Align(
             alignment: Alignment.centerRight,
             child: new IconButton(
               icon: new Icon(Icons.search,color: Colors.white,size: 32.0),
               splashColor: Colors.red,
               onPressed: (){showSearchBar();},
             )
           )
         ],
       );
  }

  void showSearchBar() {
    setState() {
      mSearchBarStatus = true;
    }
  }
}