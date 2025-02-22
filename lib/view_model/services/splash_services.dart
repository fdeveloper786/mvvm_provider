
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_practices/model/user_model.dart';
import 'package:mvvm_practices/utils/routes/routes_names.dart';
import 'package:mvvm_practices/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context)async{
    getUserData().then((value) async {
      if(kDebugMode){
        print(value.token.toString());
      }
      if(value.token == 'null' || value.token == ''){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context,RoutesName.login);
      }else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context,RoutesName.home);
      }
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

}