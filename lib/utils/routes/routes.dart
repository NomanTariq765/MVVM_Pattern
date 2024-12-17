import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_model/utils/routes/routes_name.dart';
import 'package:mvvm_model/view/home_screen.dart';
import 'package:mvvm_model/view/login_view.dart';
import 'package:mvvm_model/view/signup_view.dart';
import 'package:mvvm_model/view/splash_view.dart';

class Routes {
  static Route<dynamic>  generateRoute(RouteSettings settings) {
    final argume =settings.arguments;
    switch (settings.name) {

      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashView());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpView());


      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
              body: Center(
            child: Text('No Routes Defined'),
          ));
        });
    }
  }
}
