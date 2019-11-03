import 'package:k_pasar/util/AppConstants.dart';

abstract class PreferenceHelper {
  int getCurrentUserLoggedInMode(  );
  void setCurrentUserLoggedInMode( LoggedInMode mode );
  int getCurrentUserId(  );
  void setCurrentUserId( int userId );

  int getCurrentgroupId(  );
  void setCurrentgroupId( int groupId );

  String getCurrentUserName(  );
  void setCurrentUserName( String userName );

  String getCurrentUserEmail(  );
  void setCurrentUserEmail( String email );

  String getCurrentUserPhone(  );
  void setCurrentUserPhone( String phone );

  String getCurrentUserPassword(  );
  void setCurrentUserPassword( String password );

  String getAccessToken(  );
  void setAccessToken( String accessToken );

   String getCurrentUserImage(  );
  void setCurrentUserImage( String imageUrl );

  String getCurrentUserFirstName(  );
  void setCurrentUserFirstName( String firstName );

  String getCurrentUserLastName(  );
  void setCurrentUserLastName( String lastName );

  
  String getCurrentUserGroupName(  );
  void setCurrentUserGroupName( String groupName );

  String getCurrentUserAddress(  );
  void setCurrentUserAddress( String address );
  
}