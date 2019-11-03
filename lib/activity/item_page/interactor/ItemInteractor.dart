import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/Product.dart';

import 'ItemMVPInteractor.dart';

class ItemInteractor extends BaseInteractor implements ItemMVPInteractor
{
  ItemInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<List<Product>> loadProductByCategoryId( { int categoryId, int page = 0 } ) async {
    return apiHelper.performLoadProductByCategoryId(categoryId : categoryId ).then( (List<Product> products){
      return products;
    }  );
  }
}