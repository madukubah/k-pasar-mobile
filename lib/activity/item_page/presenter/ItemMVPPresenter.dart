import 'package:k_pasar/activity/item_page/interactor/ItemMVPInteractor.dart';
import 'package:k_pasar/activity/item_page/view/ItemMVPView.dart';

abstract class ItemMVPPresenter < V extends ItemMVPView , I extends ItemMVPInteractor > 
{
    // void onServerItemClicked( Object registerData );
    void loadProductByCategoryId( { int categoryId, int page = 0 } );
}