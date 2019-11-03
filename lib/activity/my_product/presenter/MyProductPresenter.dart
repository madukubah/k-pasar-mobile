
import 'package:k_pasar/activity/my_product/interactor/MyProductMVPInteractor.dart';
import 'package:k_pasar/activity/my_product/view/MyProductMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

import 'MyProductMVPPresenter.dart';


class MyProductPresenter < V extends MyProductMVPView , I extends MyProductMVPInteractor > extends BasePresenter< V, I > implements MyProductMVPPresenter<V, I>
{
  MyProductPresenter(MyProductMVPInteractor interactor) : super(interactor);
  @override
  void loadProductByUserId() {
    this.getView().showProgress();
    interactor.loadProductByUserId().then( ( List<Product> products ){
          this.getView().onLoadProducts( products, products.isNotEmpty );
    this.getView().hideProgress();
    });
  }

  @override
  void loadStoreByUserId() {
    this.getView().showProgress();
    interactor.loadStoreByUserId().then( ( Store store){
    if( store == null )
    {
      this.getView().hideProgress();
      this.getView().showDialogNotHaveStore();
    }

    this.getView().onLoadStore( store );
    loadProductByUserId();
    });
  }
  
}