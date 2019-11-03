import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';
// import 'package:k_pasar/model/Group.dart';

abstract class StoreMVPView extends MVPView {
  void showMessage( String message, int status );
  void onLoadStore( Store store, bool status );
  void onLoadProducts( List<Product> products, bool status );
  void onLoadGalleries( List<Gallery> galleries );

}