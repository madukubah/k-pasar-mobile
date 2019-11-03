import 'dart:io';

import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/data/network/response/ApiResponse.dart';

import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/model/Store.dart';

abstract class ProductAddMVPInteractor extends MVPInteractor {
  Future<List<Category>> getCategoryByGroupId(  );
  Future< Store > loadStoreByUserId(  );
  Future<ApiResponse> createProduct(Map<String, String> dataForm, File image);
}