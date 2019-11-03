import 'package:k_pasar/activity/my_store/interactor/MyStoreMVPInteractor.dart';
import 'package:k_pasar/activity/my_store/view/MyStoreMVPView.dart';

abstract class MyStoreMVPPresenter < V extends MyStoreMVPView , I extends MyStoreMVPInteractor > 
{
    void loadStoreByUserId();
     void loadProductByUserId();
    void loadGalleryByUserId();
   
}