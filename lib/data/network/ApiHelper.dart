import 'dart:io';

import 'package:k_pasar/data/network/response/ApiResponse.dart';
import 'package:k_pasar/data/network/response/LoginResponse.dart';
import 'package:k_pasar/model/Adverticement.dart';
import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Group.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';
import 'package:k_pasar/model/User.dart';

import 'LoginRequest.dart';

abstract class ApiHelper
{
  Future<LoginResponse> performServerLogin( LoginRequest loginRequest );
  Future<dynamic> performServerRegister( Object registerData );
  Future<User> getUserCall( int userId );
  Future<List<Group>> getGroups();

  Future<LoginResponse> performServerUpdateUser( Object userData );
  Future<LoginResponse> performUserUploadImage( File image, int userId );
  Future< List<Adverticement> > performLoadAdverticement(  );
  Future< List<Product> > performLoadProductByCategoryId(  { int categoryId, int page = 0 }  );
  Future< Product > performLoadProductDetail(  int productId   );

  Future< Store > performLoadStoreDetail(  int storeId );

  Future< List<Product> > performLoadProductByUserId( int userId );
  Future< List<Gallery> > performLoadGalleryByUserId( int userId );

  Future< List<Category> > performLoadCategoryByGroupId( int groupId );
  Future< Store > performLoadStoreByUserId(  int userId );

  Future<ApiResponse> performCreateProduct( Map<String, String> dataForm, File image );
  Future<ApiResponse> performCreateStore( Map<String, String> dataForm, File image );
  Future<ApiResponse> performEditStore( Map<String, String> dataForm, File image );
}