import 'package:k_pasar/activity/auth/register/interactor/RegisterInteractor.dart';
import 'package:k_pasar/activity/auth/register/presenter/RegisterPresenter.dart';
import 'package:k_pasar/activity/auth/register/view/RegisterMVPView.dart';
import 'package:k_pasar/data/network/AppApiHelper.dart';
import 'package:k_pasar/data/preferences/AppPreferenceHelper.dart';
import 'package:k_pasar/model/Group.dart';
import 'package:k_pasar/template/form/MyForm.dart';
import 'package:k_pasar/template/form/MyFormBuilder.dart';
import 'package:flutter/material.dart';
// import 'package:login/home_page.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:k_pasar/util/AppConstants.dart';

import 'interactor/RegisterMVPInteractor.dart';

class RegisterPage extends StatefulWidget {
  static const String tag = 'RegisterPage';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    implements RegisterMVPView {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<MyForm> dataForm = [
    MyForm(
        type: MyForm.TYPE_TEXT,
        name: "first_name",
        label: "Nama Depan",
        value: "mad"),
    MyForm(
        type: MyForm.TYPE_TEXT,
        name: "last_name",
        label: "Nama Belakang",
        value: "ukubah"),
    MyForm(
        type: MyForm.TYPE_EMAIL,
        name: "email",
        label: "Email",
        value: "alan@gmail.com"),
    MyForm(
        type: MyForm.TYPE_NUMBER,
        name: "phone",
        label: "NO HP",
        value: "081342989100"),
    MyForm(
        type: MyForm.TYPE_PASSWORD,
        name: "password",
        label: "Password",
        value: "081342989100"),
    MyForm(
        type: MyForm.TYPE_PASSWORD,
        name: "password_confirm",
        label: "Konfirmasi Password",
        value: "081342989100"),
  ];
  bool isMessageShowed = false;
  bool isGroupsShowed = false;
  String message = "";
  Color messageColor = Colors.red;

  RegisterPresenter<RegisterMVPView, RegisterMVPInteractor> presenter;
  _RegisterPageState() {
    RegisterInteractor interactor = RegisterInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter =
        RegisterPresenter<RegisterMVPView, RegisterMVPInteractor>(interactor);
  }
  @override
  void initState() {
    super.initState();
    presenter.onAttach(this);
    presenter.getGroups();
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

    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        // isButtonDisabled : true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: !isGroupsShowed
            ? null
            : () {
                if (_fbKey.currentState.saveAndValidate()) {
                  print(_fbKey.currentState.value);
                  presenter.onServerRegisterClicked(_fbKey.currentState.value);
                } else {
                  print(_fbKey.currentState.value);
                  print("validation failed");
                }
              },
        padding: EdgeInsets.all(12),
        color: AppColor.PRIMARY,
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            Visibility(
              visible: isMessageShowed,
              child: Center(
                child: Text(
                  "$message",
                  style: TextStyle(color: messageColor),
                ),
              ),
            ),
            FormBuilder(
              key: _fbKey,
              autovalidate: false,
              child: Column(
                children:
                    MyFormBuilder().create_forms(dataForm, isLabeled: true),
              ),
            ),
            SizedBox(height: 24.0),
            submitButton,
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
  void showMessage(String message, int status) {
    List<Color> messageColor = [Colors.red, Colors.green];
    setState(() {
      this.message = message;
      this.isMessageShowed = true;
      this.messageColor = messageColor[status];
    });
  }

  @override
  void attachGroups(List<Group> groups) {
    List<DropdownMenuItem> options = groups
        .map((group) => DropdownMenuItem(
              value: '${group.id}',
              child: Text('${group.description}'),
            ))
        .toList();
    MyForm group = MyForm(
        type: MyForm.TYPE_SELECT,
        name: "group_id",
        label: "Bertindak Sebagai",
        value: "mad",
        options: options);
    setState(() {
      dataForm.add(group);
      this.isGroupsShowed = true;
    });
  }
  
}
