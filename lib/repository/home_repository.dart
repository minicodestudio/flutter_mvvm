import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/res/app_url.dart';

import '../model/movies_model.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMoviesList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.movieListEndPoint);
      return MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}