import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

abstract class MyProductMVPInteractor extends MVPInteractor {
  Future< List<Product> > loadProductByUserId(); 
  Future< Store > loadStoreByUserId(  );

  
}