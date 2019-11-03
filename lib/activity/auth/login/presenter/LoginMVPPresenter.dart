import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/base/presenter/MVPPresenter.dart';
import 'package:k_pasar/base/view/MVPView.dart';

abstract class LoginMVPPresenter< V extends MVPView , I extends MVPInteractor > extends MVPPresenter< V, I >
{
  void onServerLoginClicked( String phone ,  String password );
  void start(  );
}