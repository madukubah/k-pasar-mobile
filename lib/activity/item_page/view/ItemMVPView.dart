import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/Product.dart';
// import 'package:k_pasar/model/Group.dart';

abstract class ItemMVPView extends MVPView {
  void showMessage( String message, int status );
  void onLoadItem( List<Product> products, int status );
}