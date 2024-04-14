import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_practices/data/responses/api_responses.dart';
import 'package:mvvm_practices/model/movies_model.dart';
import 'package:mvvm_practices/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{

  final _myRepo = HomeRepository();

  ApiResponse<MoviesListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesListModel> response){
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value){

      setMoviesList(ApiResponse.completed(value));

      if (kDebugMode) {
        print('movies list $value');
      }

    }).onError((error, stackTrace){

      setMoviesList(ApiResponse.error(error.toString()));

    });
  }
}