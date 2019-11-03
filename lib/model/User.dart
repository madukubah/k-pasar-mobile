class User {
  final int id;
  final String phone;
  final String email;
  final String user_fullname;
  final String image;
  final int groupId;
  final String group_name;

  final String first_name;
  final String last_name;
  final String address;
  User(
      {this.id,
      this.phone,
      this.email,
      this.user_fullname,
      this.image,
      this.groupId,

      this.first_name,
      this.group_name,
      this.last_name,
      this.address
      });

  User.fromMap(Map<String, dynamic> map)
      : id = int.parse(  map['id'] ),
        groupId = int.parse(  map['group_id'] ) ,
        phone = map['phone'] ,
        email = map['email'] ,
        user_fullname = map['user_fullname'] ,
        image = map['image'] ,

        first_name = map['first_name'] ,
        last_name = map['last_name'] ,
        address = map['address'] ,

        group_name = map['group_name'] ;
}
