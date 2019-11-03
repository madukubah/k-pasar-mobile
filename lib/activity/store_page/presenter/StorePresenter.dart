
import 'package:k_pasar/activity/store_page/interactor/StoreMVPInteractor.dart';
import 'package:k_pasar/activity/store_page/view/StoreMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';

import 'StoreMVPPresenter.dart';


class StorePresenter < V extends StoreMVPView , I extends StoreMVPInteractor > extends BasePresenter< V, I > implements StoreMVPPresenter<V, I>
{
  StorePresenter(StoreMVPInteractor interactor) : super(interactor);

  @override
  void loadStoreDetail(int storeId) {
    interactor.loadStoreDetail(storeId).then( ( Store store){
      // if( !results.isEmpty ) 
      // {
          this.getView().onLoadStore( store, store != null );
      // }
    });
  }

  @override
  void loadProductByUserId(int userId) {
    interactor.loadProductByUserId(userId).then( ( List<Product> products ){
          this.getView().onLoadProducts( products, products.isNotEmpty );
    });
  }

  @override
  void loadGalleryByUserId(int userId) {
    interactor.loadGalleryByUserId(userId).then( ( List<Gallery> galleries ){
          this.getView().onLoadGalleries( galleries );
    });
  }

  
}