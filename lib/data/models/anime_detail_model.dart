class AnimeDetailModel {
  final String image;
  final int totalFacts;
  final List<FactModel> data;

  AnimeDetailModel({
    required this.image,
    required this.data,
    required this.totalFacts,
  });

  factory AnimeDetailModel.fromJson(Map<String, dynamic> json) =>
      AnimeDetailModel(
        image: json['img'],
        totalFacts: json['total_facts'],
        data:
            List.from(json['data']).map((e) => FactModel.fromJson(e)).toList(),
      );
}

class FactModel {
  final int factId;
  final String fact;

  FactModel({
    required this.fact,
    required this.factId,
  });

  factory FactModel.fromJson(Map<String, dynamic> json) =>
      FactModel(fact: json['fact'], factId: json['fact_id']);
}
