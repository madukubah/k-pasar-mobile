import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/Group.dart';

abstract class RegisterMVPView extends MVPView {
  void showMessage( String message, int status );
  void attachGroups( List<Group> groups );
}