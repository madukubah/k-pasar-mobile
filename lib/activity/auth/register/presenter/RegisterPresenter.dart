import 'package:k_pasar/activity/auth/register/interactor/RegisterMVPInteractor.dart';
import 'package:k_pasar/activity/auth/register/view/RegisterMVPView.dart';
import 'package:k_pasar/base/interactor/MVPInteractor.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/model/Group.dart';

import 'RegisterMVPPresenter.dart';


class RegisterPresenter < V extends RegisterMVPView , I extends RegisterMVPInteractor > extends BasePresenter< V, I > implements RegisterMVPPresenter<V, I>
{
  RegisterPresenter(MVPInteractor interactor) : super(interactor);

  @override
  void onServerRegisterClicked(Object registerData) {
    this.getView().showProgress();  
    interactor.doServerRegisterApiCall( registerData ).then( ( dynamic response ){
        if( response["message"] == null ) return;

        this.getView().hideProgress();  
        int status = response["status"];//int.parse( response["status"] );
        String message =  response["message"];
        this.getView().showMessage( message.trimRight().trimLeft(), status );
        
    });
    print( registerData );
  }

  @override
  void getGroups() {
    // this.getView().showProgress(); 
    interactor.getGroups().then(( List<Group> groups ){
      print( groups[0].name ); 
      this.getView().attachGroups( groups );
      // return groups;  
    });
  }
  
}