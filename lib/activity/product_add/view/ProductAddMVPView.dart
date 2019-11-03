import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/Category.dart';
// import 'package:k_pasar/model/Group.dart';

abstract class ProductAddMVPView extends MVPView {
  void showMessage( String message, int status );
  void onCategoryLoad( List<Category> categories );
}