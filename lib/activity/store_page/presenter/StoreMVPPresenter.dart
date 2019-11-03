import 'package:k_pasar/activity/store_page/interactor/StoreMVPInteractor.dart';
import 'package:k_pasar/activity/store_page/view/StoreMVPView.dart';

abstract class StoreMVPPresenter < V extends StoreMVPView , I extends StoreMVPInteractor > 
{
    void loadStoreDetail( int storeId );
    void loadProductByUserId(int userId);
    void loadGalleryByUserId(int userId);
}