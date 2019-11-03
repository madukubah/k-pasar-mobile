import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/model/Adverticement.dart';

abstract class HomeMVPInteractor extends MVPInteractor {
  Future< List<Adverticement> > getAdverticement();
  
}