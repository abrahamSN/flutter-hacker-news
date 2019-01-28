import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Text('ini detail ${itemId}'),
      ),
    );
  }
}
