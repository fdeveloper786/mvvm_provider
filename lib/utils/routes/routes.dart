import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_practices/utils/routes/routes_names.dart';
import 'package:mvvm_practices/view/home_view.dart';
import 'package:mvvm_practices/view/login_view.dart';
import 'package:mvvm_practices/view/signup_view.dart';
import 'package:mvvm_practices/view/splash_view.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=> const SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=> const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());
        default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}