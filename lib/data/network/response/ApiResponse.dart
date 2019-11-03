
class ApiResponse
{
  final int status;
  final String message;

  ApiResponse( this.status, this.message);

  ApiResponse.fromMap(Map<String, dynamic> map)
      : status = map['status'],
        message = map['message'];
}