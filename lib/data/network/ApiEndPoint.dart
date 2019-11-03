class ApiEndPoint
{
  // static const BASE_URL = "http://192.168.43.157/k-pasar/api/";
  static const BASE_URL = "http://k-pasar.madukubah.com/api/";
  static const LOGIN = BASE_URL+"user/login";
  static const GET_USER = BASE_URL+"user/";
  static const REGISTER = BASE_URL+"user/register";

  static const UPDATE_USER = BASE_URL+"user/update";
  static const USER_UPLOAD_IMAGE = BASE_URL+"user/upload_photo";

  static const GROUPS = BASE_URL+"user/groups";
  static const ADVERTICEMENT = BASE_URL+"iklan";
  static const PRODUCT_BY_CATEGORY = BASE_URL+"product/products";
  static const PRODUCT_DETAIL = BASE_URL+"product/product";
  
  static const USER_PRODUCT = BASE_URL+"product/user_products";
  static const CREATE_PRODUCT = BASE_URL+"product/create";
  static const USER_GALLERY = BASE_URL+"gallery/user_galleries";

  static const USER_STORE = BASE_URL+"store/user_store";

  static const CATEGORY_BY_GROUP_ID = BASE_URL+"category/group_id";

  static const STORE_DETAIL = BASE_URL+"store/store";
  static const CREATE_STORE = BASE_URL+"store/create";
  static const EDIT_STORE = BASE_URL+"store/edit";

  static const PRODUCT_IMAGE = "http://k-pasar.madukubah.com/uploads/product";

}