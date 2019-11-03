import 'dart:io';

import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/network/response/ApiResponse.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/model/Store.dart';

import 'ProductAddMVPInteractor.dart';

class ProductAddInteractor extends BaseInteractor implements ProductAddMVPInteractor
{
  ProductAddInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<List<Category>> getCategoryByGroupId(  ) async {
    int groupId = preferenceHelper.getCurrentgroupId();
    return apiHelper.performLoadCategoryByGroupId(  groupId ).then(( List<Category> categories ){
      // print( groups[0].name );
      return categories;  
    });
  }

  @override
  Future<Store> loadStoreByUserId() async{
    int userId = preferenceHelper.getCurrentUserId();
    return apiHelper.performLoadStoreByUserId( userId).then( ( Store store ){
      return store;
    } );
  }

  @override
  Future<ApiResponse> createProduct(Map<String,String > dataForm, File image) {
    int userId = preferenceHelper.getCurrentUserId();
    return apiHelper.performLoadStoreByUserId( userId ).then( ( Store store ){
      dataForm["store_id"] = "${store.id}";
      print( dataForm );
          return apiHelper.performCreateProduct( dataForm, image ).then( ( ApiResponse result ){
            return result;
          }  );
    }  );
    
  }
}