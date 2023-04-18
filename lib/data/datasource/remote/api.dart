import 'package:dio/dio.dart';
import 'package:movieapp/data/datasource/remote/config.dart';
import 'package:movieapp/data/datasource/remote/constants.dart';
import 'package:movieapp/data/model/MovieResponse.dart';

class APIService {
  APIService._();
  static final APIService api = APIService._();

  Future<MovieResponse> fetchMovieInfo() async {
    Dio dio = Config.getDio();
    Map<String, dynamic> params = {"api_key": apiKey};
    Response response = await dio.get("popular", queryParameters: params);
    if(response.statusCode == 200){
      return MovieResponse.fromJson(response.data);
    } else {
      throw Exception("unable to get Movie Data");
    }
  }
}