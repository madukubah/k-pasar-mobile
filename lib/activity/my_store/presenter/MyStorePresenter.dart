
import 'package:k_pasar/activity/my_store/interactor/MyStoreMVPInteractor.dart';
import 'package:k_pasar/activity/my_store/view/MyStoreMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

import 'MyStoreMVPPresenter.dart';


class MyStorePresenter < V extends MyStoreMVPView , I extends MyStoreMVPInteractor > extends BasePresenter< V, I > implements MyStoreMVPPresenter<V, I>
{
  MyStorePresenter(MyStoreMVPInteractor interactor) : super(interactor);

   @override
  void loadStoreByUserId() {
    this.getView().showProgress();
    interactor.loadStoreByUserId().then( ( Store store){
    if( store == null )
    {
      this.getView().showDialogNotHaveStore();
      return ;
    }

    this.getView().onLoadStore( store );

    loadProductByUserId();
    loadGalleryByUserId() ;

    this.getView().hideProgress();
    });
  }

  @override
  void loadProductByUserId() {
    interactor.loadProductByUserId().then( ( List<Product> products ){
          this.getView().onLoadProducts( products );
    });
  }

  @override
  void loadGalleryByUserId() {
    interactor.loadGalleryByUserId().then( ( List<Gallery> galleries ){
          this.getView().onLoadGalleries( galleries );
    });
  }
}