import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';
// import 'package:k_pasar/model/Group.dart';

abstract class MyStoreMVPView extends MVPView {
  void showMessage( String message, int status );
  void onLoadStore( Store store );
  Future<void> showDialogNotHaveStore() ;
    void onLoadProducts( List<Product> products );
  void onLoadGalleries( List<Gallery> galleries );
}