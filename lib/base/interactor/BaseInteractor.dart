import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/network/response/LoginResponse.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/User.dart';
import 'package:k_pasar/util/AppConstants.dart';

import 'MVPInteractor.dart';

class BaseInteractor extends MVPInteractor
{
  final PreferenceHelper preferenceHelper ;
  final  ApiHelper apiHelper ;

  BaseInteractor(  this.preferenceHelper, this.apiHelper );

  
  @override
  Future< bool > isUserLoggedIn() async {
    return  this.preferenceHelper.getCurrentUserLoggedInMode() != LoggedInMode.LOGGED_IN_MODE_LOGGED_OUT.index;
  }

  @override
  void performUserLogout() {
    this.preferenceHelper.setCurrentUserLoggedInMode( LoggedInMode.LOGGED_IN_MODE_LOGGED_OUT );
    this.preferenceHelper.setCurrentUserId( null );
    this.preferenceHelper.setAccessToken( "" );
    this.preferenceHelper.setCurrentUserEmail( "" );
    this.preferenceHelper.setCurrentUserPhone( "");
    this.preferenceHelper.setCurrentUserName( "");
    this.preferenceHelper.setCurrentUserImage( "assets/images/as.png" );
  }

  @override
  void updateUserInSharedPref(LoginResponse loginResponse, LoggedInMode loggedInMode) {
    User user = loginResponse.user_data;
    if( user != null )
    {
        preferenceHelper.setCurrentUserId( user.id );
        preferenceHelper.setCurrentgroupId( user.groupId );

        preferenceHelper.setCurrentUserName( user.user_fullname );
        preferenceHelper.setCurrentUserEmail( user.email );
        preferenceHelper.setCurrentUserPhone( user.phone );
        preferenceHelper.setCurrentUserLoggedInMode( loggedInMode );
        preferenceHelper.setCurrentUserImage( user.image );
        preferenceHelper.setCurrentUserFirstName( user.first_name );
        preferenceHelper.setCurrentUserLastName( user.last_name );
        preferenceHelper.setCurrentUserGroupName( user.group_name );
        preferenceHelper.setCurrentUserAddress( user.address );
    }
  }
}