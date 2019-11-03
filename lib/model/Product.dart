class Product {
  final int id;
  final int categoryId;
  final int storeId;
  final int hit;
  final double price;
  final String unit;
  final String storeName;
  
  final String userFullname;
  final String userImage;
  final String usersPhone;

  final String name;
  final String description;
  final String images;

  Product.fromMap(Map<String, dynamic> map)
      : id = int.parse(map['id']),
        categoryId = int.parse(map['category_id']),
        storeId = int.parse(map['store_id']),
        hit = int.parse(map['hit']),
        price = double.parse(map['price']),
        storeName = map['store_name'],
        name = map['name'],
        unit = map['unit'],
        images = map['images'],

        userFullname = map['user_fullname'],
        userImage = map['user_image'],
        usersPhone = map['users_phone'],

        description = map['description'];
}
