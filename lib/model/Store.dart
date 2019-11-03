class Store {
  final int id;
  final int userId;

  final String name;
  final String description;

  final String images;
  final String address;
  final int startDate;
  final String groupsName;

  final String userFullname;
  final String userImage;
  final String usersPhone;

  Store( {
    this.id =0 , 
    this.userId = 0, 
    this.name = "", 
    this.description = "", 
    this.images = "", 
    this.address = "", 
    this.startDate = 0, 
    this.groupsName = "", 
    this.userFullname = "", 
    this.userImage = "", 
    this.usersPhone = ""
  } );

  Store.fromMap(Map<String, dynamic> map)
      : id = int.parse(map['id']),
        userId = int.parse(map['user_id']),
        name = map['name'],
        description = map['description'],
        images = map['images'],
        address = map['address'],
        startDate = int.parse( map['start_date'] ),

        userFullname = map['user_fullname'],
        userImage = map['user_image'],
        usersPhone = map['users_phone'],

        groupsName = map['groups_name']
        ;
}
