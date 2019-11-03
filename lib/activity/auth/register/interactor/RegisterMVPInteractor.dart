import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Group.dart';

abstract class RegisterMVPInteractor extends MVPInteractor {
  Future<dynamic> doServerRegisterApiCall( Object registerData );
  Future<List<Group>> getGroups();
  
}