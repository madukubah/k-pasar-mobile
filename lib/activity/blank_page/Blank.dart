
import 'package:k_pasar/activity/blank_page/view/BlankMVPView.dart';
import 'package:k_pasar/template/drawer/Menu.dart';
import 'package:k_pasar/template/drawer/PlainDrawer.dart';
import 'package:k_pasar/util/AppConstants.dart';
import 'package:flutter/material.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/BlankInteractor.dart';
import 'interactor/BlankMVPInteractor.dart';
import 'presenter/BlankPresenter.dart';

class Blank extends StatefulWidget {
  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> implements BlankMVPView {

  BlankPresenter<BlankMVPView, BlankMVPInteractor> presenter;
  
  _BlankState() {
    BlankInteractor interactor = BlankInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = BlankPresenter<BlankMVPView, BlankMVPInteractor>(interactor);
    this.presenter.onAttach(this);
  }
  List<Menu> menus = [
    Menu(title: "Usaha Saya", routename: "/Profile"),
    Menu(title: "Produk Saya", routename: "/Profile"),
    Menu(title: "Galeri", routename: "/Profile"),
    Menu(title: "Pengaturan", routename: "/Profile"),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${AppConstants.APP_NAME}")),
      drawer: new PlainDrawer(
        menus: menus,
        onTap: ( Menu menu ){
            print( menu.routename );
        },
      ),
      body: new Container(),
    );
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void showMessage(String message, int status) {
    // TODO: implement showMessage
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }
}
