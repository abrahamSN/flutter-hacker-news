import 'package:flutter/material.dart';

import 'dart:async';

import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel data) {
    return Card(
      child: ListTile(
        title: Text(data.title),
        subtitle: Text('${data.score} votes'),
        trailing: Column(
          children: <Widget>[
            Icon(Icons.comment),
            Text('${data.descendants}'),
          ],
        )
      ),
    );
  }
}
