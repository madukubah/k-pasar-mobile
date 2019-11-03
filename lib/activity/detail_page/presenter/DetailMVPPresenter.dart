import 'package:k_pasar/activity/detail_page/interactor/DetailMVPInteractor.dart';
import 'package:k_pasar/activity/detail_page/view/DetailMVPView.dart';

abstract class DetailMVPPresenter < V extends DetailMVPView , I extends DetailMVPInteractor > 
{
    void loadProductDetail(int productId);
    Future<bool> isUserLoggedIn();
}