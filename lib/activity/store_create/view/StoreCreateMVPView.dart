import 'package:k_pasar/base/view/MVPView.dart';
// import 'package:k_pasar/model/Group.dart';

abstract class StoreCreateMVPView extends MVPView {
  void showMessage( String message, int status );
  void popPage( String message, int status );
}