import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_practices/model/user_model.dart';
import 'package:mvvm_practices/repository/auth_repository.dart';
import 'package:mvvm_practices/utils/routes/routes_names.dart';
import 'package:mvvm_practices/utils/utils.dart';
import 'package:mvvm_practices/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{


  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }


  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginApi(data).then((value) {
      final userViewModel = Provider.of<UserViewModel>(context,listen: false);
      setLoading(false);
      userViewModel.saveUser(
          UserModel(
          token: value.toString()
        )
      );
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    await _myRepo.registerApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}

