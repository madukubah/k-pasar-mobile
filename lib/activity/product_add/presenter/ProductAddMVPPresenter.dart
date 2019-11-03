import 'dart:io';

import 'package:k_pasar/activity/product_add/interactor/ProductAddMVPInteractor.dart';
import 'package:k_pasar/activity/product_add/view/ProductAddMVPView.dart';

abstract class ProductAddMVPPresenter < V extends ProductAddMVPView , I extends ProductAddMVPInteractor > 
{
    void getcategory();
    void loadStoreByUserId( );
    void createProduct(Map<String, dynamic> dataForm, File image);
} 