import 'dart:io';

import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/data/network/response/LoginResponse.dart';
import 'package:k_pasar/model/User.dart';

abstract class ProfileMVPInteractor extends MVPInteractor {
  // Future<dynamic> doServerProfileApiCall( Object registerData );
  Future<User> getUser(int userId);
  int getUserId();
  
  Future<LoginResponse> doServerUpdateUser( Object userData );
  Future<LoginResponse> doUploadImage(File image);
}