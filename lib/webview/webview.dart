import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic wbs = ModalRoute.of(context).settings.arguments;
    var url = wbs["url"];
    print("url");
    return Scaffold(
      appBar: PreferredSize(child: GradientAppBar(wbs["title"]), preferredSize: Size.fromHeight(70)),
      body: WebView(
        initialUrl: url, 
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 70.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                }),
            )
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.title,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xff13e860), Color(0xbf0781e5)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.9, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}