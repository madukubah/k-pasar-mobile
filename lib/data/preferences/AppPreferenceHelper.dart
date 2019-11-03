import 'package:k_pasar/util/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PreferenceHelper.dart';

class AppPreferenceHelper extends PreferenceHelper
{
  static const PREF_KEY_USER_LOGGED_IN_MODE = "PREF_KEY_USER_LOGGED_IN_MODE";
  static const PREF_KEY_CURRENT_USER_ID = "PREF_KEY_CURRENT_USER_ID";
  static const PREF_KEY_CURRENT_GROUP_ID = "PREF_KEY_CURRENT_GROUP_ID";

  static const PREF_KEY_ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";
  static const PREF_KEY_CURRENT_USER_NAME = "PREF_KEY_CURRENT_USER_NAME";
  static const PREF_KEY_CURRENT_USER_EMAIL = "PREF_KEY_CURRENT_USER_EMAIL";
  static const PREF_KEY_CURRENT_USER_PHONE = "PREF_KEY_CURRENT_USER_PHONE";
  static const PREF_KEY_CURRENT_USER_PASSWORD = "PREF_KEY_CURRENT_USER_PASSWORD";
  static const PREF_KEY_CURRENT_USER_IMAGE = "PREF_KEY_CURRENT_USER_IMAGE";

  static const PREF_KEY_CURRENT_USER_ADDRESS = "PREF_KEY_CURRENT_USER_ADDRESS";
  static const PREF_KEY_CURRENT_USER_FNAME = "PREF_KEY_CURRENT_USER_FNAME";
  static const PREF_KEY_CURRENT_USER_LNAME = "PREF_KEY_CURRENT_USER_LNAME";
  static const PREF_KEY_CURRENT_USER_GROUP_NAME = "PREF_KEY_CURRENT_USER_GROUP_NAME";

  // Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  SharedPreferences sharedPreferences;

  static  AppPreferenceHelper _singleton ;
  static AppPreferenceHelper getInstance()
  {
    if( _singleton == null )
    {
      return _singleton =  AppPreferenceHelper();
    }
    return _singleton;
  }

  AppPreferenceHelper()
  {
    _init(  ) ;
  }
  _init(  ) async {
    sharedPreferences = await SharedPreferences.getInstance();
    // this.setCurrentUserLoggedInMode(LoggedInMode.LOGGED_IN_MODE_LOGGED_OUT);
  }
  @override
  String getAccessToken() {
    return sharedPreferences.getString( PREF_KEY_ACCESS_TOKEN );
  }

  @override
  String getCurrentUserEmail() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_EMAIL );
  }

  @override
  int getCurrentUserId() {
      var userId = sharedPreferences.getInt( PREF_KEY_CURRENT_USER_ID );
      if( userId == AppConstants.NULL_INDEX ) return null;
      return userId;
  }

  @override
  int getCurrentUserLoggedInMode() {
    return sharedPreferences.getInt( PREF_KEY_USER_LOGGED_IN_MODE );
  }

  @override
  String getCurrentUserName() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_NAME );

  }

  @override
  void setAccessToken(String accessToken) {
    sharedPreferences.setString(PREF_KEY_ACCESS_TOKEN, accessToken);

  }

  @override
  void setCurrentUserEmail(String email) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_EMAIL, email);

  }

  @override
  void setCurrentUserId(int userId) {
    userId = ( userId == null ) ? AppConstants.NULL_INDEX : userId ;
    sharedPreferences.setInt(PREF_KEY_CURRENT_USER_ID, userId);
  }

  @override
  void setCurrentUserLoggedInMode(LoggedInMode mode) {
    sharedPreferences.setInt(PREF_KEY_USER_LOGGED_IN_MODE, mode.index );
  }

  @override
  void setCurrentUserName(String userName) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_NAME, userName);
  }

  @override
  String getCurrentUserPassword() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_PASSWORD );
  }

  @override
  String getCurrentUserPhone() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_PHONE );
  }

  @override
  void setCurrentUserPassword(String password) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_PASSWORD, password);
  }

  @override
  void setCurrentUserPhone(String phone) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_PHONE, phone);
  }

  @override
  String getCurrentUserImage() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_IMAGE );    
  }

  @override
  void setCurrentUserImage(String imageUrl) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_IMAGE, imageUrl);
  }

  @override
  String getCurrentUserAddress() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_ADDRESS );    
  }

  @override
  String getCurrentUserFirstName() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_FNAME );    
  }

  @override
  String getCurrentUserGroupName() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_GROUP_NAME );    
  }

  @override
  String getCurrentUserLastName() {
    return sharedPreferences.getString( PREF_KEY_CURRENT_USER_LNAME );    
  }

  @override
  void setCurrentUserAddress(String address) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_ADDRESS, address);
  }

  @override
  void setCurrentUserFirstName(String firstName) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_FNAME, firstName);
  }

  @override
  void setCurrentUserGroupName(String groupName) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_GROUP_NAME, groupName);
  }

  @override
  void setCurrentUserLastName(String lastName) {
    sharedPreferences.setString(PREF_KEY_CURRENT_USER_LNAME, lastName);
  }

  @override
  int getCurrentgroupId() {
    var groupId = sharedPreferences.getInt( PREF_KEY_CURRENT_GROUP_ID );
      if( groupId == AppConstants.NULL_INDEX ) return null;
      return groupId;
  }

  @override
  void setCurrentgroupId(int groupId) {
    groupId = ( groupId == null ) ? AppConstants.NULL_INDEX : groupId ;
    sharedPreferences.setInt(PREF_KEY_CURRENT_GROUP_ID, groupId);
  }
  
}