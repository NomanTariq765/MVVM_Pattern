import 'package:flutter/cupertino.dart';
import 'package:mvvm_model/data/response/api_response.dart';
import 'package:mvvm_model/model/movie_model.dart';
import 'package:mvvm_model/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier{

  final _myRepo  = HomeRepository();
  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();
  setMovieList(ApiResponse<MovieListModel>response){
    moviesList = response;
    notifyListeners();
  }
  Future<void> fetchMovieListApi()async{
    setMovieList(ApiResponse.loading());
    _myRepo.FetchMoviesList().then((value){
      setMovieList(ApiResponse.completed(value));
    }).onError((error , stackTrace){
      setMovieList(ApiResponse.error(error.toString()));
    });
  }
}