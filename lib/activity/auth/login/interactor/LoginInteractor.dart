import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/network/LoginRequest.dart';
import 'package:k_pasar/data/network/response/LoginResponse.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';

import 'package:k_pasar/util/AppConstants.dart';

import 'LoginMVPInteractor.dart';

class LoginInteractor extends BaseInteractor implements LoginMVPInteractor
{
  LoginInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper) {
    
  }
  String password = "";
  @override
  Future<LoginResponse> doServerLoginApiCall(String identity, String password) async {
      print( "doServerLoginApiCall" );
      this.password = password;
      return apiHelper.performServerLogin( LoginRequest(
        identity : identity ,
        password : password ,
      ) ).then( ( LoginResponse loginResponse ){
          return loginResponse;
      } );
  }

  @override
  void updateUserInSharedPref(LoginResponse loginResponse, LoggedInMode loggedInMode) {
    // User user = loginResponse.user_data;
    preferenceHelper.setCurrentUserPassword( this.password );
    super.updateUserInSharedPref( loginResponse,  loggedInMode);
  } 
    
}