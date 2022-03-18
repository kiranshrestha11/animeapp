import 'dart:developer';

import 'package:animeapp/data/models/anime_list_model.dart';
import 'package:animeapp/data/repository/anime_repository.dart';
import 'package:animeapp/presentation/anime_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<AnimeListModel>>(
        future: AnimeRepository().getAllAnime(),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView.builder(
              itemCount: snap.data!.length,
              itemBuilder: (context, index) {
                final _item = snap.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => AnimeDetailPage(
                              name: _item.name,
                            )));
                  },
                  leading: Image.network(_item.image),
                  title: Text(_item.name),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
