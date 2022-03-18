import 'dart:developer';
import 'dart:io';
import 'package:animeapp/data/core/api_client.dart';
import 'package:animeapp/data/models/anime_detail_model.dart';
import 'package:animeapp/data/models/anime_list_model.dart';

class AnimeRepository {
  Future<List<AnimeListModel>> getAllAnime() async {
    try {
      final result = await ApiClient().getData();
      final List data = result['data'];
      return data.map((e) => AnimeListModel.fromJson(e)).toList();
    } on SocketException catch (e) {
      throw Exception('Internet not connected!');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AnimeDetailModel> getAnimeDetail({required String animeName}) async {
    try {
      final data = await ApiClient().getData(endpoint: animeName);

      return AnimeDetailModel.fromJson(data);
    } on SocketException catch (e) {
      throw Exception('Internet not connected!');
    } catch (e) {
      throw Exception(e);
    }
  }
}
