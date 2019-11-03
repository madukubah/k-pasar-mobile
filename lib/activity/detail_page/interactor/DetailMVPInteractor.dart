import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Product.dart';

abstract class DetailMVPInteractor extends MVPInteractor {
  Future< Product > loadProductDetail( int productId );
}