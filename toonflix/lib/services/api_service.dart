import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(res.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final detail = jsonDecode(res.body);

      return WebtoonDetailModel.fromJson(detail);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> webtoonEpisodes = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final episodes = jsonDecode(res.body);

      for (var episode in episodes) {
        webtoonEpisodes.add(WebtoonEpisodeModel.fromJSon(episode));
      }

      return webtoonEpisodes;
    }
    throw Error();
  }
}
