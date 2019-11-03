import 'package:k_pasar/model/User.dart';

class LoginResponse
{
  final int status;
  final String message;
  final User user_data;

  LoginResponse( this.status, this.message, this.user_data);

  LoginResponse.fromMap(Map<String, dynamic> map)
      : status = map['status'],
        message = map['message'],
        user_data = ( map['user_data'] == null ) ? null: ( map['user_data'].isEmpty ) ? null: new User.fromMap( map['user_data'] );
}