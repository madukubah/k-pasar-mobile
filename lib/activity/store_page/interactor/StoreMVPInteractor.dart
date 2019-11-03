import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

abstract class StoreMVPInteractor extends MVPInteractor {
  Future< Store > loadStoreDetail( int storeId );
  Future< List<Product> > loadProductByUserId(int userId);
  Future< List<Gallery> > loadGalleryByUserId(int userId);
}