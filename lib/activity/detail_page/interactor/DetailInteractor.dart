import 'package:k_pasar/base/interactor/BaseInteractor.dart';
import 'package:k_pasar/data/network/ApiHelper.dart';
import 'package:k_pasar/data/preferences/PreferenceHelper.dart';
import 'package:k_pasar/model/Product.dart';

import 'DetailMVPInteractor.dart';

class DetailInteractor extends BaseInteractor implements DetailMVPInteractor
{
  DetailInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<Product> loadProductDetail(int productId) async {
   return apiHelper.performLoadProductDetail( productId).then( ( Product product ){
      return product;
    }  );
  }

  

}