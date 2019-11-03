
import 'package:k_pasar/activity/detail_page/interactor/DetailMVPInteractor.dart';
import 'package:k_pasar/activity/detail_page/view/DetailMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';

import 'DetailMVPPresenter.dart';


class DetailPresenter < V extends DetailMVPView , I extends DetailMVPInteractor > extends BasePresenter< V, I > implements DetailMVPPresenter<V, I>
{
  DetailPresenter(DetailMVPInteractor interactor) : super(interactor);

  @override
  void loadProductDetail(int productId) {
    interactor.loadProductDetail(productId);
  }

  @override
  Future<bool> isUserLoggedIn() {
    return interactor.isUserLoggedIn().then( ( bool loggedIn ){
          return loggedIn ;
        } );
  }

  
}