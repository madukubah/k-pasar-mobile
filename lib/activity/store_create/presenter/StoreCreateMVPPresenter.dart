import 'dart:io';

import 'package:k_pasar/activity/store_create/interactor/StoreCreateMVPInteractor.dart';
import 'package:k_pasar/activity/store_create/view/StoreCreateMVPView.dart';
import 'package:k_pasar/model/Store.dart';

abstract class StoreCreateMVPPresenter < V extends StoreCreateMVPView , I extends StoreCreateMVPInteractor > 
{
    void createStore(Map<String, dynamic> dataForm, File image);
    void editStore(Map<String, dynamic> dataForm, File image, Store store);
    
}