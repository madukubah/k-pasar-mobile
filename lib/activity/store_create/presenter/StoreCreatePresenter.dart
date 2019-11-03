
import 'dart:io';

import 'package:k_pasar/activity/store_create/interactor/StoreCreateMVPInteractor.dart';
import 'package:k_pasar/activity/store_create/view/StoreCreateMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/data/network/response/ApiResponse.dart';
import 'package:k_pasar/model/Store.dart';

import 'StoreCreateMVPPresenter.dart';


class StoreCreatePresenter < V extends StoreCreateMVPView , I extends StoreCreateMVPInteractor > extends BasePresenter< V, I > implements StoreCreateMVPPresenter<V, I>
{
  StoreCreatePresenter(StoreCreateMVPInteractor interactor) : super(interactor);

  @override
  void createStore(Map<String,dynamic > dataForm, File image) {
      this.getView().showProgress();
    if( image == null ) {
      this.getView().showMessage( "Gambar tidak ada", 0 );
      this.getView().hideProgress();
      return;
    }
    Map<String, String > _dataForm = {
      "name" : dataForm["name"].toString(),
      "description" : dataForm["description"].toString(),
      "start_date" : dataForm["start_date"].toString(),
      "address" : dataForm["address"].toString(),
    };

    interactor.createStore( _dataForm , image ).then( ( ApiResponse result ){
      // print( result.message );
      if( result != null )
      {
        this.getView().showMessage( result.message, result.status );
      }
      this.getView().hideProgress();
    });
  }

  @override
  void editStore(Map<String, dynamic> dataForm, File image, Store store) {
    this.getView().showProgress();
    Map<String, String > _dataForm = {
      "name" : dataForm["name"].toString(),
      "description" : dataForm["description"].toString(),
      "start_date" : dataForm["start_date"].toString(),
      "address" : dataForm["address"].toString(),
      "store_id" : "${store.id}",
      "old_image" : "${store.images}",
    };

    interactor.editStore( _dataForm , image ).then( ( ApiResponse result ){
      // print( result.message );
      if( result != null )
      {
        this.getView().showMessage( result.message, result.status );
        if( result.status == 1 )
          this.getView().popPage( result.message, result.status );
      }
      this.getView().hideProgress();
    });
  }
 
}