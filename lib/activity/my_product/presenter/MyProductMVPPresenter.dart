import 'package:k_pasar/activity/my_product/interactor/MyProductMVPInteractor.dart';
import 'package:k_pasar/activity/my_product/view/MyProductMVPView.dart';

abstract class MyProductMVPPresenter < V extends MyProductMVPView , I extends MyProductMVPInteractor > 
{
    void loadProductByUserId();
    void loadStoreByUserId();
}