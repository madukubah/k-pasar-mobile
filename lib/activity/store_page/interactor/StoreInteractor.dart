import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

import 'StoreMVPInteractor.dart';

class StoreInteractor extends BaseInteractor implements StoreMVPInteractor
{
  StoreInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<Store> loadStoreDetail(int storeId) async{
    return apiHelper.performLoadStoreDetail( storeId).then( ( Store store ){
      return store;
    }  );
  }

  @override
  Future<List<Product>> loadProductByUserId(int userId) async {
    return apiHelper.performLoadProductByUserId(userId ).then( (List<Product> products){
      return products;
    }  );
  }

  @override
  Future<List<Gallery>> loadGalleryByUserId(int userId) async {
   return apiHelper.performLoadGalleryByUserId(userId ).then( (List<Gallery> galleries){
      return galleries;
    }  );
  }
}