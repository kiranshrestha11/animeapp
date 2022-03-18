import 'package:animeapp/data/models/anime_detail_model.dart';
import 'package:animeapp/data/repository/anime_repository.dart';
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  double imageHeight = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(
                  () {
                    //imageHeight = imageHeight + 10;
                    imageHeight += 10;
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<AnimeDetailModel>(
        future: AnimeRepository().getAnimeDetail(animeName: widget.name),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView(
              children: [
                ImageWidget(image: snap.data!.image, height: 200),

                // Column(
                //   children: snap.data!.data
                //       .map((e) => ListTile(
                //             title: Text(e.fact),
                //           ))
                //       .toList(),
                // )
                Column(
                  children: [
                    TotalFacts(factsCount: snap.data!.totalFacts),
                    ...snap.data!.data.map((e) => ListTile(
                          title: Text(e.fact),
                        ))
                  ],
                ),
                // FactsWidget(
                //   count: snap.data!.data.length,
                //   data: snap.data!.data,
                // ),
              ],
            );
          } else if (snap.hasError) {
            return Text(snap.error.toString());
          } else {
            return const ProgressIndicator();
          }
        },
      ),
    );
  }
}

class FactsWidget extends StatelessWidget {
  const FactsWidget({
    Key? key,
    required this.data,
    required this.count,
  }) : super(key: key);
  final int count;
  final List<FactModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index].fact),
        );
      },
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key, required this.image, this.height = 300})
      : super(key: key);
  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TotalFacts extends StatelessWidget {
  const TotalFacts({Key? key, required this.factsCount}) : super(key: key);
  final int factsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.amber,
      child: Text('Total facts : $factsCount'),
    );
  }
}
