import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/Adverticement.dart';

import 'HomeMVPInteractor.dart';

class HomeInteractor extends BaseInteractor implements HomeMVPInteractor
{
  HomeInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<List<Adverticement>> getAdverticement() {
    return apiHelper.performLoadAdverticement().then( (List<Adverticement> result ){
      return result;
    } );
  }

}