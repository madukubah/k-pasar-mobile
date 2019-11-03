import 'package:k_pasar/base/view/MVPView.dart';
import 'package:k_pasar/model/Adverticement.dart';

abstract class HomeMVPView extends MVPView {
  void showMessage( String message, int status );
  void toLoginPage(  );
  void onIsUserLogin( bool isLoggedIn );
  void onLoadAdverticement( List<Adverticement> adverticements );
}