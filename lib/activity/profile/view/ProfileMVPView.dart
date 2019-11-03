import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/User.dart';
// import 'package:k_pasar/model/Group.dart';

abstract class ProfileMVPView extends MVPView {
  void showMessage( String message, int status );
  void showProgressCircle(  );
  void hideProgressCircle(  );
  void onUserLoad( User user );

}