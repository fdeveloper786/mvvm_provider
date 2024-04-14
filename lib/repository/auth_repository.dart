import 'package:mvvm_practices/data/network/base_api_services.dart';
import 'package:mvvm_practices/data/network/network_api_services.dart';
import 'package:mvvm_practices/resources/app_url.dart';

class AuthRepository {

  BaseApiServices _apiServices = NetworkApiServices();


  /// Method to login existing User
  Future<dynamic> loginApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppEndPoints.loginEndPoint, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

  /// Method to register new User
  Future<dynamic> registerApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppEndPoints.registerEndPoint, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

}