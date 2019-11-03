import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

import 'MyStoreMVPInteractor.dart';

class MyStoreInteractor extends BaseInteractor implements MyStoreMVPInteractor
{
  MyStoreInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<Store> loadStoreByUserId() async {
    int userId = preferenceHelper.getCurrentUserId();
    return apiHelper.performLoadStoreByUserId( userId).then( ( Store store ){
      return store;
    } );
  }
  
  @override
  Future<List<Product>> loadProductByUserId() async {
    int userId = preferenceHelper.getCurrentUserId();

    return apiHelper.performLoadProductByUserId(userId ).then( (List<Product> products){
      return products;
    }  );
  }

  @override
  Future<List<Gallery>> loadGalleryByUserId() async {
    int userId = preferenceHelper.getCurrentUserId();

   return apiHelper.performLoadGalleryByUserId(userId ).then( (List<Gallery> galleries){
      return galleries;
    }  );
  }
}