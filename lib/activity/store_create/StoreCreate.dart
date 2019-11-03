import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:k_pasar/activity/store_create/view/StoreCreateMVPView.dart';
import 'package:k_pasar/model/Store.dart';
import 'package:k_pasar/template/form/MyForm.dart';
import 'package:k_pasar/template/form/MyFormBuilder.dart';
import 'package:k_pasar/util/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/StoreCreateInteractor.dart';
import 'interactor/StoreCreateMVPInteractor.dart';
import 'presenter/StoreCreatePresenter.dart';

import 'package:image/image.dart' as _image;

class StoreCreate extends StatefulWidget {
  final bool editMode;
  final Store store;

  const StoreCreate({Key key, this.editMode = false, this.store})
      : super(key: key);
  @override
  _StoreCreateState createState() => _StoreCreateState();
}

class _StoreCreateState extends State<StoreCreate>
    implements StoreCreateMVPView {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  File _imageFile;

  bool isMessageShowed = false;
  bool isGroupsShowed = false;
  String message = "";
  Color messageColor = Colors.red;
  List<MyForm> dataForm = List();

  StoreCreatePresenter<StoreCreateMVPView, StoreCreateMVPInteractor> presenter;

  _StoreCreateState() {
    StoreCreateInteractor interactor = StoreCreateInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter =
        StoreCreatePresenter<StoreCreateMVPView, StoreCreateMVPInteractor>(
            interactor);
    this.presenter.onAttach(this);
  }
  @override
  void initState() {
    dataForm = [
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "name",
          label: "Nama Usaha",
          value: (this.widget.store != null) ? this.widget.store.name : ""),
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "description",
          label: "Deskrpisi Usaha",
          value:
              (this.widget.store != null) ? this.widget.store.description : ""),
      MyForm(
          type: MyForm.TYPE_DATE_PICKTER,
          name: "start_date",
          label: "Tanggal Berdiri",
          value: (this.widget.store != null)
              ? (DateTime.fromMillisecondsSinceEpoch(
                  this.widget.store.startDate * 1000))
              : DateTime.now()),
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "address",
          label: "Alamat Usaha",
          value: (this.widget.store != null) ? this.widget.store.address : ""),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            print(_fbKey.currentState.value);
            if(this.widget.editMode)
              presenter.editStore(_fbKey.currentState.value, _imageFile, this.widget.store );
            else  
              presenter.createStore(_fbKey.currentState.value, _imageFile);
          } else {
            print(_fbKey.currentState.value);
            print("validation failed");
          }
        },
        padding: EdgeInsets.all(12),
        color: AppColor.PRIMARY,
        child: Text('Simpan', style: TextStyle(color: Colors.white)),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Buat Usaha Saya"),
        backgroundColor: AppColor.PRIMARY,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
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
              children: MyFormBuilder().create_forms(dataForm, isLabeled: true),
            ),
          ),
          SizedBox(height: 8.0),
          Center(
            child: FlatButton(
              child: new CircleAvatar(
                backgroundColor: AppColor.PRIMARY,
                radius: 25.0,
                child: new Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _getImage(context, ImageSource.gallery);
                // _openImagePickerModal( context );
                print("CAMERA");
              },
            ),
          ),
          SizedBox(height: 4.0),
          this._imageFile == null
              ? (this.widget.editMode)
                  ? Image.network(
                      this.widget.store.images,
                      fit: BoxFit.cover,
                      height: 300.0,
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Image.asset(
                      "assets/images/placehoder.jpg",
                      fit: BoxFit.cover,
                      height: 300.0,
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                    )
              : Image.file(
                  _imageFile,
                  fit: BoxFit.cover,
                  height: 300.0,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                ),
          SizedBox(height: 24.0),
          submitButton,
        ],
      ),
    );
  }

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    // // Closes the bottom sheet
    // Navigator.pop(context);
    if (image != null) {
      _image.Image imageFile = _image.decodeJpg(image.readAsBytesSync());

      _image.Image thumbnail = _image.copyResize(imageFile, width: 500);

      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      print(appDocDirectory.path);
      print(Directory.current.path);

      // return;
      // new Directory(Directory.current.path +'k-pasar').create(recursive: true)
      new Directory(appDocDirectory.path + '/k-pasar').create(recursive: true)
          // The created directory is returned as a Future.
          .then((Directory directory) {
        var name = DateTime.now().millisecondsSinceEpoch;
        File(directory.path + '/$name.png')
            .writeAsBytesSync(_image.encodePng(thumbnail));

        File imageThumbnail = File(directory.path + '/$name.png');

        setState(() {
          this._imageFile = imageThumbnail;
        });
        // presenter.uploadImage(imageThumbnail);
        print('Path of New Dir: ' + directory.path);
      });
    } else
      print("tidak ada gambar");
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
  void popPage(String message, int status) {
    Navigator.pop(context, '$message');
  }
}
