
import 'dart:io';

import 'package:k_pasar/activity/product_add/interactor/ProductAddMVPInteractor.dart';
import 'package:k_pasar/activity/product_add/view/ProductAddMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/data/network/response/ApiResponse.dart';
import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/model/Store.dart';

import 'ProductAddMVPPresenter.dart';


class ProductAddPresenter < V extends ProductAddMVPView , I extends ProductAddMVPInteractor > extends BasePresenter< V, I > implements ProductAddMVPPresenter<V, I>
{
  ProductAddPresenter(ProductAddMVPInteractor interactor) : super(interactor);

  @override
  void getcategory() {
    interactor.getCategoryByGroupId().then( (List<Category> categories){
      this.getView().onCategoryLoad(  categories );
    } );
  }

  @override
  void loadStoreByUserId() {
    interactor.loadStoreByUserId().then( ( Store store){
      // if( !results.isEmpty ) 
      // {
          // this.getView().onLoadStore( store, store != null );
      // }
    });
  }

  @override
  void createProduct(Map<String, dynamic > dataForm, File image) {
      this.getView().showProgress();
    if( image == null ) {
      this.getView().showMessage( "Gambar tidak ada", 0 );
      this.getView().hideProgress();
      return;
    }
    Map<String, String > _dataForm = {
      "name" : dataForm["name"].toString(),
      "description" : dataForm["description"].toString(),
      "price" : dataForm["price"].toString(),
      "unit" : dataForm["unit"].toString(),
      "category_id" : dataForm["category_id"].toString(),
    };
    interactor.createProduct( _dataForm , image ).then( ( ApiResponse result ){
      // print( result.message );
      if( result != null )
      {
        this.getView().showMessage( result.message, result.status );
      }
      this.getView().hideProgress();
    });
  }
}