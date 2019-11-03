import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';

import 'BlankMVPInteractor.dart';

class BlankInteractor extends BaseInteractor implements BlankMVPInteractor
{
  BlankInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  // @override
  // Future<dynamic> doServerBlankApiCall(Object registerData) async {
  //   return apiHelper.performServerBlank(registerData).then( ( dynamic response ){
  //       // final responsea = JsonDecoder().convert( response );
  //       print( response["message"] );
  //       return response;
  //   });
  // }

  // @override
  // Future<List<Group>> getGroups()  {
  //   return apiHelper.getGroups().then(( List<Group> groups ){
  //     // print( groups[0].name );      
  //     return groups;  
  //   });
  // }
  

}