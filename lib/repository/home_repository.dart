import 'package:mvvm_model/model/movie_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/components/app_url.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> FetchMoviesList()async{
    try{
      dynamic response  = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}