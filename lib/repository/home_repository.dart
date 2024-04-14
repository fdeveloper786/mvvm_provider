import 'package:mvvm_practices/data/network/base_api_services.dart';
import 'package:mvvm_practices/data/network/network_api_services.dart';
import 'package:mvvm_practices/model/movies_model.dart';
import 'package:mvvm_practices/resources/app_url.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<MoviesListModel> fetchMoviesList() async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppEndPoints.moviesListEndPoint);
      return response = MoviesListModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}