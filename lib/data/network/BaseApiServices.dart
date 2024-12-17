//abstract class
abstract class BaseApiServices{
  //two functions
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url,dynamic data);

}