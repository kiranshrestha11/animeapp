class AnimeListModel {
  final int id;
  final String name;
  final String image;

  AnimeListModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory AnimeListModel.fromJson(Map<String, dynamic> json) => AnimeListModel(
        id: json['anime_id'],
        image: json['anime_img'],
        name: json['anime_name'],
      );
}
