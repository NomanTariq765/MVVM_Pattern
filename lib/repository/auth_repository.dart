import 'package:mvvm_model/data/network/BaseApiServices.dart';
import 'package:mvvm_model/data/network/NetworkApiServices.dart';

import '../resources/components/app_url.dart';

class AuthRepository{
  BaseApiServices _apiServices = NetworkApiServices();
  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response  = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint,data);
          return response;
    }catch(e){
      throw e;
    }
  }
  Future<dynamic> signUpApi(dynamic data)async{
    try{
      dynamic response  = await _apiServices.getPostApiResponse(AppUrl.registeredApiEndPoint,data);
      return response;
    }catch(e){
      throw e;
    }
  }

}