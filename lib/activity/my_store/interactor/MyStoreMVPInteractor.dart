import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

abstract class MyStoreMVPInteractor extends MVPInteractor {
  Future< Store > loadStoreByUserId(  );
  Future< List<Product> > loadProductByUserId();
  Future< List<Gallery> > loadGalleryByUserId();
}