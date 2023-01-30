import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = 'today';

  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      print(res.body);
      return;
    }

    throw Error();
  }
}
