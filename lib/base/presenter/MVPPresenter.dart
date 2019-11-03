

import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/base/view/MVPView.dart';

abstract class MVPPresenter < V extends MVPView , I extends MVPInteractor > 
{
  void onAttach( V view );
  void onDetach(  );
  V getView(  );
}