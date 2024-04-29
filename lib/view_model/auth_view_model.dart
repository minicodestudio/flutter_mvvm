import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_respository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(data).then((value){

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString()
        )
      );

      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      print(value.toString());
      setLoading(false);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
      setLoading(false);
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {

    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value){
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      print(value.toString());
      setSignUpLoading(false);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
      setSignUpLoading(false);
    });
  }
}