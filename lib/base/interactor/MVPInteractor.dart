import 'package:k_pasar/data/network/response/LoginResponse.dart';
import 'package:k_pasar/util/AppConstants.dart';

abstract class MVPInteractor {
  Future< bool > isUserLoggedIn(  );
  void performUserLogout(  );
  void updateUserInSharedPref( LoginResponse loginResponse, LoggedInMode loggedInMode );
}