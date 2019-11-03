import 'package:k_pasar/activity/main/interactor/HomeMVPInteractor.dart';
import 'package:k_pasar/activity/main/view/HomeMVPView.dart';

abstract class HomeMVPPresenter < V extends HomeMVPView , I extends HomeMVPInteractor > 
{
    void logout(  );
    void start(  );    
}