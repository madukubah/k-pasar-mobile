
import 'dart:async';

import 'package:k_pasar/activity/main/interactor/HomeMVPInteractor.dart';
import 'package:k_pasar/activity/main/view/HomeMVPView.dart';
import 'package:k_pasar/base/presenter/BasePresenter.dart';
import 'package:k_pasar/model/Adverticement.dart';

import 'HomeMVPPresenter.dart';


class HomePresenter < V extends HomeMVPView , I extends HomeMVPInteractor > extends BasePresenter< V, I > implements HomeMVPPresenter<V, I>
{
  HomePresenter(HomeMVPInteractor interactor) : super(interactor);

  @override
  void logout() {
    interactor.performUserLogout();
    interactor.isUserLoggedIn().then( ( bool loggedIn ){
      print( "loggedIn $loggedIn" );
      if( !loggedIn ) 
        this.getView().onIsUserLogin(loggedIn);
        // this.getView().toLoginPage(  );
    } );
  }

   @override
  Future start() async {
    interactor.getAdverticement().then( (List<Adverticement> result ){
      if( !result.isEmpty ) 
      {
          this.getView().onLoadAdverticement(result);
      }
    });

    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, (){
        interactor.isUserLoggedIn().then( ( bool loggedIn ){
          print( "isUserLoggedIn ${ loggedIn }" );
          this.getView().onIsUserLogin(loggedIn);
        } );
    });
  }
  
}