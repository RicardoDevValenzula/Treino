import 'package:flutter/material.dart';

class MinimalLoader extends StatefulWidget {
  @override
  _MinimalLoaderState createState() => _MinimalLoaderState();
}

class _MinimalLoaderState extends State<MinimalLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RefreshProgressIndicator(),
      ),
    );
  }
}
