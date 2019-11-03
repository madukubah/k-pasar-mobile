import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/base/view/MVPView.dart';

import 'MVPPresenter.dart';

class BasePresenter < V extends MVPView, I extends MVPInteractor > extends MVPPresenter<V, I>
{
  final I interactor;
  V view;

  BasePresenter(this.interactor );

  @override
  V getView() {
    return this.view;
  }

  @override
  void onAttach(V view) {
    this.view = view;
  }

  @override
  void onDetach() {
    // TODO: implement onDetach
  }
 
}