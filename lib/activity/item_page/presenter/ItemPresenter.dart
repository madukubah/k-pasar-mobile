
import 'package:k_pasar/activity/item_page/interactor/ItemMVPInteractor.dart';
import 'package:k_pasar/activity/item_page/view/ItemMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/model/Product.dart';

import 'ItemMVPPresenter.dart';


class ItemPresenter < V extends ItemMVPView , I extends ItemMVPInteractor > extends BasePresenter< V, I > implements ItemMVPPresenter<V, I>
{
  ItemPresenter(ItemMVPInteractor interactor) : super(interactor);

  @override
  void loadProductByCategoryId( { int categoryId, int page = 0 }) {
    interactor.loadProductByCategoryId( categoryId : categoryId ).then( ( List<Product> results){
      // if( !results.isEmpty ) 
      // {
          this.getView().onLoadItem( results, 1 );
      // }

    });
  }
  
}