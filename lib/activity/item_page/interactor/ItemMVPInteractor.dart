import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Product.dart';

abstract class ItemMVPInteractor extends MVPInteractor {
  Future< List<Product> > loadProductByCategoryId( { int categoryId, int page = 0 });
}