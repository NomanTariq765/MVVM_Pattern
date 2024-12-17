import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_model/model/user_model.dart';
import 'package:mvvm_model/repository/auth_repository.dart';
import 'package:mvvm_model/utils/routes/routes_name.dart';
import 'package:mvvm_model/utils/utils.dart';
import 'package:mvvm_model/view/home_screen.dart';
import 'package:mvvm_model/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _signUploading = false;
  bool get signUploading => _signUploading;
  setSinUploading(bool value){
    _signUploading = value;
    notifyListeners();
  }
  Future<void> loginApi(dynamic data, BuildContext context) async {
    setloading(true);
    _myRepo.loginApi(data).then((value) {
      setloading(false);
      final userPreference  = Provider.of<UserViewModel>(context,listen: false );
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString(),
        )
      );
      Utils.flushBarErrorMessage('Login Sucessfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setloading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSinUploading(true);
    _myRepo.signUpApi(data).then((value) {
      setSinUploading(false);
      Utils.flushBarErrorMessage('SignUp Sucessfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSinUploading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}
