

import 'package:k_pasar/activity/auth/register/interactor/RegisterMVPInteractor.dart';
import 'package:k_pasar/activity/auth/register/view/RegisterMVPView.dart';

abstract class RegisterMVPPresenter < V extends RegisterMVPView , I extends RegisterMVPInteractor > 
{
    void onServerRegisterClicked( Object registerData );
    void getGroups(  );
}