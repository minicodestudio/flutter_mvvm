import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/signup_view.dart';
import 'package:mvvm/view/splash_view.dart';

import '../../view/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpView());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}