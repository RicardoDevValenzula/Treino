import 'package:flutter/material.dart';


class Info extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minHeight: constraints.maxHeight,
            maxHeight: double.infinity,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
               SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                   // Multiple widgets and form fields
                    Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
             Container(
              height: 75,
              decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
              child: Row(
                children: [
                  Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                  ),
                ],
              ),
            ),
            

                  ],
                ),
              ),
            ),
          ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("nel") // Your footer widget
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
  
}