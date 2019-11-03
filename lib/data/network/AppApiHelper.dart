import 'dart:convert';
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
import 'package:k_pasar/util/fetch_data_exception.dart';
import 'package:mime/mime.dart';

import 'ApiEndPoint.dart';
import 'ApiHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

class AppApiHelper extends ApiHelper 
{
  static final AppApiHelper _singleton = AppApiHelper._internal();
  AppApiHelper._internal();
  static AppApiHelper getInstance()
  {
    if( _singleton == null )
    {
      return new AppApiHelper._internal();
    }
    return _singleton;
  }
  Map<String, String> headers = {"Content-type": "application/json"};
  @override
  Future<LoginResponse> performServerLogin(loginRequest) async 
  {
    return http.post(ApiEndPoint.LOGIN, body: loginRequest.toJson() )
      .then(( http.Response response ){
          final String jsonBody = response.body;
          // //print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
           final loginContainer = JsonDecoder().convert(jsonBody);
            // print( loginContainer['user_data']['phone'] );
          return LoginResponse.fromMap( loginContainer );
      });
  }

  @override
  Future<dynamic> performServerRegister(Object registerData) async {
    return http.post(ApiEndPoint.REGISTER, body: registerData )
      .then(( http.Response response ){
          final String jsonBody = response.body;
          // //print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          
          final container = JsonDecoder().convert(jsonBody);
          // print( container["message"] );

          return container;
      });
  }

  @override
  Future<List<Group>> getGroups() async {
    print( "getGroups" );
    return http.get(ApiEndPoint.GROUPS).then((http.Response response)  {
       final String jsonBody = response.body;
          // //print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          
          final container = JsonDecoder().convert(jsonBody);
          List<Group> groups = List();
          for (var i = 0; i < container.length; i++) 
          {
              groups.add( new Group.fromMap ( container[i] ) );
          }
          return groups;
   
    });
  }

  @override
  Future<User> getUserCall(int userId) async {
    return http.get(ApiEndPoint.GET_USER+"$userId").then((http.Response response)  {
       final String jsonBody = response.body;
          // //print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);

          return ( jsonBody == null ) ? null: new User.fromMap( container );
         
    });
  }

  @override
  Future<LoginResponse> performServerUpdateUser(Object userData) async {
    return http.post(ApiEndPoint.UPDATE_USER, body: userData )
      .then(( http.Response response ){
          final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          
          final container = JsonDecoder().convert(jsonBody);
          // print( container["message"] );
          // return null;
          return LoginResponse.fromMap( container );
      });
  }

  @override
  Future<LoginResponse> performUserUploadImage(File image, int userId) async {

    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    print( mimeTypeData );
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse( ApiEndPoint.USER_UPLOAD_IMAGE ));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path,
        // contentType: MediaType  );
    contentType: http_parser.MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields["user_id"] = "$userId";
    imageUploadRequest.files.add(file);
     try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }

      final String jsonBody = response.body;
          // print( jsonBody );

      final container = JsonDecoder().convert(jsonBody);
      // _resetState();
      // return responseData;
      return LoginResponse.fromMap( container );
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Adverticement>> performLoadAdverticement() async {
    print( "getGroups" );
    return http.get(ApiEndPoint.ADVERTICEMENT ).then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          
          final container = JsonDecoder().convert(jsonBody);
          List<Adverticement> adverticement = List();
          for (var i = 0; i < container.length; i++) 
          {
              adverticement.add( new Adverticement.fromMap ( container[i] ) );
          }
          return adverticement;
    });
  }

  @override
  Future<List<Product>> performLoadProductByCategoryId( { int categoryId, int page = 0 } ) async {
    print( "performLoadProductByCategoryId" );
    return http.get(ApiEndPoint.PRODUCT_BY_CATEGORY+"/$categoryId"+"?page=$page" ).then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);
          List<Product> products = List();
          for (var i = 0; i < container.length; i++)
          {
              products.add( new Product.fromMap ( container[i] ) );
          }
          return products;
    });
  }

  @override
  Future< Product > performLoadProductDetail(int productId) async {
    print( "performLoadProductDetail" );
    return http.get(ApiEndPoint.PRODUCT_DETAIL+"/$productId").then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          return null;
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);
          return new Product.fromMap ( container);
    });
  }

  @override
  Future<Store> performLoadStoreDetail(int storeId) async {
    // storeId = 1000;
    print( "performLoadProductDetail" );
    return http.get(ApiEndPoint.STORE_DETAIL+"/$storeId").then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);
          return ( container == null ) ? null :  new Store.fromMap ( container);
    });
  }

  @override
  Future<List<Product>> performLoadProductByUserId(int userId) async {
    return http.get(ApiEndPoint.USER_PRODUCT+"/$userId" ).then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);
          List<Product> products = List();
          for (var i = 0; i < container.length; i++)
          {
              products.add( new Product.fromMap ( container[i] ) );
          }
          return products;
    });
  }

  @override
  Future<List<Gallery>> performLoadGalleryByUserId(int userId) {
    return http.get(ApiEndPoint.USER_GALLERY+"/$userId" ).then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);
          List<Gallery> galleries = List();
          for (var i = 0; i < container.length; i++)
          {
              galleries.add( new Gallery.fromMap ( container[i] ) );
          }
          return galleries;
    });
  }

  @override
  Future<List<Category>> performLoadCategoryByGroupId(int groupId) {
          // print( "groupId/$groupId" );
    return http.get(ApiEndPoint.CATEGORY_BY_GROUP_ID +"/$groupId" ).then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          final statusCode = response.statusCode;
          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }
          final container = JsonDecoder().convert(jsonBody);
          List<Category> categories = List();
          for (var i = 0; i < container.length; i++)
          {
              categories.add( new Category.fromMap ( container[i] ) );
          }
          return categories;
    });
  }

  @override
  Future<Store> performLoadStoreByUserId(int userId) async {
    return http.get(ApiEndPoint.USER_STORE +"/$userId" ).then((http.Response response)  {
       final String jsonBody = response.body;
          // print( jsonBody );
          // final statusCode = response.statusCode;
          // if (statusCode < 200 || statusCode >= 300 ) {
          //   throw new FetchDataException(
          //       "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          // }
          var container ;
          if( jsonBody != "" )
            container = JsonDecoder().convert(jsonBody);
            
          return ( container == null ) ? null :  new Store.fromMap ( container);
    });
  }

  @override
  Future<ApiResponse> performEditStore(Map<String, String> dataForm, File image) async {
    
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse( ApiEndPoint.EDIT_STORE ));
    imageUploadRequest.fields.addAll( dataForm );
     if( image != null ) {
          final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
          final file = await http.MultipartFile.fromPath('image', image.path,
          contentType: http_parser.MediaType(mimeTypeData[0], mimeTypeData[1]));
          imageUploadRequest.files.add(file);
    }
    
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      // if (response.statusCode != 200) {
      //   return null;
      // }
      final String jsonBody = response.body;
          print( jsonBody );
      final container = JsonDecoder().convert(jsonBody);
      // _resetState();
      // return responseData;
      return ApiResponse.fromMap( container );
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ApiResponse> performCreateStore(Map<String, String> dataForm, File image) async {
    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    print( mimeTypeData );
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse( ApiEndPoint.CREATE_STORE ));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path,
        // contentType: MediaType  );
    contentType: http_parser.MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.fields.addAll( dataForm );
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      // if (response.statusCode != 200) {
      //   return null;
      // }
      final String jsonBody = response.body;
          print( jsonBody );
      final container = JsonDecoder().convert(jsonBody);
      // _resetState();
      // return responseData;
      return ApiResponse.fromMap( container );
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ApiResponse> performCreateProduct(Map<String, String> dataForm, File image) async {
    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    print( mimeTypeData );
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse( ApiEndPoint.CREATE_PRODUCT ));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path,
        // contentType: MediaType  );
    contentType: http_parser.MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.fields.addAll( dataForm );
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      // if (response.statusCode != 200) {
      //   return null;
      // }
      final String jsonBody = response.body;
          print( jsonBody );
      final container = JsonDecoder().convert(jsonBody);
      // _resetState();
      // return responseData;
      return ApiResponse.fromMap( container );
    } catch (e) {
      print(e);
      return null;
    }
  }
}