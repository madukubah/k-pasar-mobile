import 'dart:io';

import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/network/response/ApiResponse.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';

import 'StoreCreateMVPInteractor.dart';

class StoreCreateInteractor extends BaseInteractor implements StoreCreateMVPInteractor
{
  StoreCreateInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<ApiResponse> createStore(Map<String, String> dataForm, File image) {
    int userId = preferenceHelper.getCurrentUserId();
    dataForm["user_id"] = "${userId}";
    // print(dataForm);return null;
    return apiHelper.performCreateStore( dataForm, image ).then( ( ApiResponse result ){
      return result;
    }  );
  }

  @override
  Future<ApiResponse> editStore(Map<String, String> dataForm, File image) {
    return apiHelper.performEditStore( dataForm, image ).then( ( ApiResponse result ){
      return result;
    }  );
  }

}