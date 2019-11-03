import 'package:k_pasar/activity/auth/login/presenter/LoginPresenter.dart';
import 'package:k_pasar/activity/auth/login/view/LoginMVPView.dart';
import 'package:k_pasar/data/network/AppApiHelper.dart';
import 'package:k_pasar/data/preferences/AppPreferenceHelper.dart';
import 'package:k_pasar/template/form/MyForm.dart';
import 'package:k_pasar/template/form/MyFormBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:k_pasar/util/AppConstants.dart';

import 'interactor/LoginInteractor.dart';
import 'interactor/LoginMVPInteractor.dart';

class LoginPage extends StatefulWidget {
  static const String tag = 'LoginPage';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginMVPView {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  LoginPresenter<LoginMVPView, LoginMVPInteractor> presenter;

  bool isMessageShowed = false;
  String message = "";
  Color messageColor = Colors.red;
  
  List<MyForm> dataForm = [
    MyForm(
        type: MyForm.TYPE_NUMBER,
        name: "phone",
        label: "NO HP",
        value: "081342989179",
        ),
    MyForm(
        type: MyForm.TYPE_PASSWORD,
        name: "password",
        label: "Password",
        value: "yuhu123"),
  ];

  _LoginPageState() {
    LoginInteractor interactor = LoginInteractor( AppPreferenceHelper.getInstance() , AppApiHelper.getInstance() );
    presenter = LoginPresenter<LoginMVPView, LoginMVPInteractor>(interactor);
  }
  @override
  void initState() {
    presenter.onAttach(this);
    super.initState();
    presenter.start();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            print(_fbKey.currentState.value);
            presenter.onServerLoginClicked(_fbKey.currentState.value['phone'],
                _fbKey.currentState.value['password']);
          } else {
            print(_fbKey.currentState.value);
            print("validation failed");
          }
        },
        padding: EdgeInsets.all(12),
        color: AppColor.PRIMARY,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Belum punya akun? Register',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed("/RegisterPage");
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                Visibility(
                  visible: isMessageShowed,
                  child : Center(
                    child: Text(
                    "$message",
                    style: TextStyle(color: messageColor  ),
                ),
                  ),
                ),
                FormBuilder(
                  key: _fbKey,
                  autovalidate: false,
                  child: Column(
                    children: MyFormBuilder().create_forms(dataForm ),
                  ),
                ),
                SizedBox(height: 24.0),
                loginButton,
                forgotLabel
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void hideProgress() {
    Navigator.pop(context);
  }

  @override
  void showProgress() {
    print("showProgress");
    showDialog(
      barrierDismissible: false,
      context: context,
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
   @override
  void dispose() {
    debugPrint('disposed...');
    super.dispose();
  }
  @override
  void showValidationMessage(int errorCode) {
    // TODO: implement showValidationMessage
  }

  @override
  void showMessage(String message, int status) {
    List<Color> messageColor = [ Colors.red, Colors.green ];
    setState(() {
      this.message = message;
      this.isMessageShowed = true;
      this.messageColor = messageColor[ status ];
    });
  }

  @override
  void openMainAvtivity() {
    Navigator.of(context).pushReplacementNamed("/Home");
  }
}
