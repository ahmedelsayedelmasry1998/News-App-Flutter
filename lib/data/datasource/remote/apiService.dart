import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapplication/data/models/newsChannelHadlineModel.dart';
import '../../../utils/constants.dart';

class ApiService {
  ApiService._();
  static final ApiService api = ApiService._();
  Future<NewsChannelsHandelingModel> fetchNewsChannelHeadlinesApi() async {
    http.Response response = await http.get(Uri.parse(urlNews));
    if (response.statusCode == 200) {
      return NewsChannelsHandelingModel.fromJson(jsonDecode(response.body));
    } else {
      return throw new Exception("Unable To Fetch");
    }
  }

  Future<NewsChannelsHandelingModel> fetchCustomNewsChannelHeadlinesApi(
      String? queryString) async {
    String url = "https://dummyjson.com/products/search?q=$queryString";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return NewsChannelsHandelingModel.fromJson(jsonDecode(response.body));
    } else {
      return throw new Exception("Unable To Fetch");
    }
  }
}
