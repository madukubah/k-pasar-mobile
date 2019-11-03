import 'dart:io';

import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/data/network/response/ApiResponse.dart';

abstract class StoreCreateMVPInteractor extends MVPInteractor {
  Future<ApiResponse> createStore(Map<String, String> dataForm, File image);
  Future<ApiResponse> editStore(Map<String, String> dataForm, File image);
  
}