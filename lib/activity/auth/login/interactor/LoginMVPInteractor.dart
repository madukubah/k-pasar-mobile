import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/data/network/response/LoginResponse.dart';
import 'package:k_pasar/util/AppConstants.dart';

abstract class LoginMVPInteractor extends MVPInteractor
{
    Future<LoginResponse> doServerLoginApiCall( String identity,  String password );
    // void updateUserInSharedPref( LoginResponse loginResponse, LoggedInMode loggedInMode );
}