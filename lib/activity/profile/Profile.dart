import 'dart:io';
// import 'dart:io' as dir;

import 'package:k_pasar/activity/profile/interactor/ProfileInteractor.dart';
import 'package:k_pasar/activity/profile/presenter/ProfilePresenter.dart';
import 'package:k_pasar/activity/profile/view/ProfileMVPView.dart';
import 'package:k_pasar/data/network/AppApiHelper.dart';
import 'package:k_pasar/data/preferences/AppPreferenceHelper.dart';
import 'package:k_pasar/model/User.dart';
import 'package:k_pasar/template/form/MyForm.dart';
import 'package:k_pasar/template/form/MyFormBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'interactor/ProfileMVPInteractor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as _image;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin
    implements ProfileMVPView {
  String pageName = "Profil";
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProfilePresenter<ProfileMVPView, ProfileMVPInteractor> presenter;

  List<MyForm> dataForm = List();

  _ProfileState() {
    ProfileInteractor interactor = ProfileInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter =
        ProfilePresenter<ProfileMVPView, ProfileMVPInteractor>(interactor);
  }

  bool _allowWriteFile = false;

  @override
  void initState() {
    super.initState();
    presenter.onAttach(this);
    presenter.getUser();
     requestWritePermission();
  }

    requestWritePermission() async {
    PermissionStatus permissionStatus = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
 
    if (permissionStatus == PermissionStatus.authorized) {
      setState(() {
        _allowWriteFile = true;
      });
    }
  }

  bool _status = true;
  bool userLoad = true;
  Widget message = Container();
  User user;
  String imageProfile = 'assets/images/as.png';
  final FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 250.0,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.0),
                                  child: new Text(pageName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: 'sans-serif-light',
                                          color: Colors.black)),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child:
                            new Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: ( imageProfile == "assets/images/as.png" )
                                          ?  new ExactAssetImage(imageProfile)
                                          :new NetworkImage(imageProfile),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ), onPressed: () {
                                      _getImage(context, ImageSource.gallery);
                                      // _openImagePickerModal( context );
                                      print( "CAMERA" );
                                    },
                                  )
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                message //Message from api
                ,
                new Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: userLoad
                        ? new Center(
                            child: new Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: new CircularProgressIndicator(),
                            ),
                          )
                        : new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Informasi Akun',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status
                                            ? _getEditIcon()
                                            : new Container(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 24.0, right: 24.0),
                                child: Column(
                                  children: <Widget>[
                                    FormBuilder(
                                      key: _fbKey,
                                      autovalidate: false,
                                      child: Column(
                                        children: MyFormBuilder().create_forms(
                                            dataForm,
                                            isLabeled: true,
                                            decorationType:
                                                DecorationType.PLAIN,
                                            readonly: _status),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                      this.presenter.updateUser( _fbKey.currentState.value );
                    } else {
                      print(_fbKey.currentState.value);
                      print("validation failed");
                    }
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
          this.dataForm.removeLast();
        });
      },
    );
  }

  @override
  void hideProgress() {
    // Navigator.pop(context);
    this.userLoad = false;
  }

  @override
  void showProgress() {
    setState(() {
      message = Container();  
    });
    this.userLoad = true;
  }

  @override
  void showMessage(String message, int status) {
    List<Color> messageColor = [Colors.red, Colors.green];
    setState(() {
        this.message = Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Text(
              "$message",
              style: TextStyle(color: messageColor[ status ]),
            ),
          ),
        );

    });
  }

  @override
  void onUserLoad(User user) {
    this.user = user;

    List<MyForm> dataForm = [
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "first_name",
          label: "Nama Depan",
          value: user.first_name),
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "last_name",
          label: "Nama Belakang",
          value: user.last_name),
      MyForm(
          type: MyForm.TYPE_EMAIL,
          name: "email",
          label: "Email",
          value: user.email),
      MyForm(
          type: MyForm.TYPE_NUMBER,
          name: "phone",
          label: "NO HP",
          value: user.phone
          ),
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "address",
          label: "Alamat",
          value: user.address),
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "group_name",
          label: "Group",
          value: user.group_name),
    ];
    
    setState(() {
      this.imageProfile = user.image;
      this.dataForm = dataForm;
      this.userLoad = false;
      this._status = true;
    });
  }

  //Image Upload

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    // // Closes the bottom sheet
    // Navigator.pop(context);    
    if( image != null )
    {
      _image.Image imageFile = _image.decodeJpg( image.readAsBytesSync() );

      _image.Image thumbnail = _image.copyResize( imageFile, width: 100 );

      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      print( appDocDirectory.path );
      print( Directory.current.path );

      // return;
      // new Directory(Directory.current.path +'k-pasar').create(recursive: true)
      new Directory(appDocDirectory.path +'/k-pasar').create(recursive: true)
      // The created directory is returned as a Future.
          .then((Directory directory) {
            File( directory.path + '/thumbnail-test.png').writeAsBytesSync( _image.encodePng(thumbnail) );

            File imageThumbnail = File( directory.path + '/thumbnail-test.png' );
            
            presenter.uploadImage(imageThumbnail);
            print('Path of New Dir: '+directory.path);
      });
    }
    else
      print( "tidak ada gambar" );
  }
    void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void showProgressCircle() {
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
  void hideProgressCircle() {
    Navigator.pop(context);
  }
}
