import 'package:bloc_clean_arch/data/data.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserProvider();

  UserModel? _userModel;

  UserModel get userModel => _userModel!;

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  void clear() {
    _userModel = null;
    notifyListeners();
  }
}
