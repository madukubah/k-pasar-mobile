import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k_pasar/activity/product_add/view/ProductAddMVPView.dart';
import 'package:flutter/material.dart';
import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/template/form/MyForm.dart';
import 'package:k_pasar/template/form/MyFormBuilder.dart';
import 'package:k_pasar/util/AppConstants.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/ProductAddInteractor.dart';
import 'interactor/ProductAddMVPInteractor.dart';
import 'presenter/ProductAddPresenter.dart';

import 'package:image/image.dart' as _image;

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> implements ProductAddMVPView {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  File _imageFile;

  bool isMessageShowed = false;
  bool isGroupsShowed = false;
  String message = "";
  Color messageColor = Colors.red;
  List<MyForm> dataForm = [
    MyForm(
        type: MyForm.TYPE_TEXT,
        name: "name",
        label: "Nama Product",
        value: "mad"),
    MyForm(
        type: MyForm.TYPE_TEXT,
        name: "description",
        label: "Keterangan",
        value: "ukubah"),
    MyForm(
        type: MyForm.TYPE_NUMBER,
        name: "price",
        label: "Harga",
        value: "50000"),
    MyForm(
      type: MyForm.TYPE_TEXT,
      name: "unit",
      label: "Satuan ( Kg/ Ekor/ .. )",
    ),
  ];
  ProductAddPresenter<ProductAddMVPView, ProductAddMVPInteractor> presenter;

  _ProductAddState() {
    ProductAddInteractor interactor = ProductAddInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = ProductAddPresenter<ProductAddMVPView, ProductAddMVPInteractor>(
        interactor);
    this.presenter.onAttach(this);
  }

  @override
  void initState() {
    super.initState();
    presenter.getcategory();
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: !isGroupsShowed
            ? null
            : () {
                if (_fbKey.currentState.saveAndValidate()) {
                  print(_fbKey.currentState.value);
                  presenter.createProduct(_fbKey.currentState.value, _imageFile );
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
        title: new Text("Tambah Produk"),
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
          SizedBox( height: 4.0 ),
          this._imageFile == null
              ? Image.asset(
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
  void onCategoryLoad(List<Category> categories) {
    List<DropdownMenuItem> options = categories
        .map((group) => DropdownMenuItem(
              value: '${group.id}',
              child: Text('${group.name}'),
            ))
        .toList();
    MyForm category = MyForm(
        type: MyForm.TYPE_SELECT,
        name: "category_id",
        label: "Kategori",
        options: options);
    setState(() {
      dataForm.insert(0, category);
      this.isGroupsShowed = true;
    });
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
}
