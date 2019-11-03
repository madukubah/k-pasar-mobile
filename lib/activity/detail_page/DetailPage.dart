
import 'package:intl/intl.dart';
import 'package:k_pasar/activity/detail_page/view/DetailMVPView.dart';
import 'package:k_pasar/activity/store_page/StorePage.dart';
import 'package:k_pasar/data/network/ApiEndPoint.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:k_pasar/util/AppConstants.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/DetailInteractor.dart';
import 'interactor/DetailMVPInteractor.dart';
import 'presenter/DetailPresenter.dart';

import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  // final int itemId;
  final Product product;

  const DetailPage({Key key, this.product}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> implements DetailMVPView {

  DetailPresenter<DetailMVPView, DetailMVPInteractor> presenter;
  
  _DetailPageState() {
    DetailInteractor interactor = DetailInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = DetailPresenter<DetailMVPView, DetailMVPInteractor>(interactor);
    this.presenter.onAttach(this);
  }
  @override
  void initState() {
    this.presenter.loadProductDetail(this.widget.product.id );
    super.initState();
  }

  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    List<String> imagesArr = this.widget.product.images.split(";");
    var formatter = new NumberFormat.decimalPattern();
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    TextStyle style15BoldWhite = new TextStyle(
      inherit: true,
      fontSize: 15 * devicePixelRatio,
      color: Colors.white,
    );
    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 8 * devicePixelRatio,
      color: Colors.black,
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height / 10),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.7,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: new Image.network(
                          '${ApiEndPoint.PRODUCT_IMAGE}/${imagesArr[0]}',
                          fit: BoxFit.cover,
                        ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xCC000000),
                                  const Color(0xCC000000),
                                  const Color(0x00000000),
                                  const Color(0x00000000),
                                  const Color(0xCC000000),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: (MediaQuery.of(context).size.height / 2.7) / 8,
                            left: 20.0,
                            right: 20.0,
                            child: Text(
                          "${this.widget.product.name}",                              
                              style: style15BoldWhite,
                            ),
                          ),
                          Positioned(
                            // bottom: ( MediaQuery.of(context).size.height / 8 ) / 2,
                            bottom: 0.0,
                            left: 30.0,
                            right: 30.0,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: Container(
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(
                                      "Rp. ${formatter.format(this.widget.product.price)}/${this.widget.product.unit}",
                                      style: style15BoldWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Keterangan",
                                        style: style15,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("5", style: style15),
                                      IconButton(
                                        icon: new Icon(Icons.star),
                                        color: Colors.green,
                                        onPressed: () {},
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text( "${this.widget.product.hit}" , style: style15),
                                      IconButton(
                                        icon: new Icon(Icons.remove_red_eye),
                                        color: Colors.green,
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                "${this.widget.product.description}",
                                style: style15),
                            // Text("Pemilik", style: style15),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          print("tap");
                          toStorePage( this.widget.product.storeId );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${this.widget.product.userImage}"), // no matter how big it is, it won't overflow
                        ),
                        title: Text( "${this.widget.product.storeName}" ),
                        subtitle: Text("${this.widget.product.userFullname}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.message),
                                color: Colors.green,
                                onPressed: ()  {
                                  print( "message" );
                                  this.contactProduct("message");

                                },
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              IconButton(
                                icon: Icon(Icons.phone),
                                color: Colors.green,
                                onPressed: () async {
                                  print( "phone" );
                                  this.contactProduct("phone");
                                },
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.add_shopping_cart),
                              //   color: Colors.green,
                              //   onPressed: () {},
                              // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   backgroundColor: Colors.green,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.shopping_cart),
      // ),
    );
  }

  void contactProduct( mode )
  {
    this.presenter.isUserLoggedIn().then(  ( bool loggedIn ){

        if( !loggedIn ) {
          this.showDialogNotLogin();
          return;
        }

        switch( mode )
        {
          case "message":
            launch("sms:${this.widget.product.usersPhone}");
            // launch("sms:${this.widget.product.usersPhone}?body=hello%20there");
            break;
          case "phone":
            launch("tel://${this.widget.product.usersPhone}");
            break;
        }
    } );
    
  }


  Future<void> showDialogNotLogin() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Belum Login'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Mohon untuk Login terlebih dahulu'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Batal',
            style: TextStyle( color: Colors.red ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Ok',
            style: TextStyle( color: AppColor.PRIMARY )
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/LoginPage');
            },
          ),
        ],
      );
    },
  );
}

  void toStorePage( int storeId ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StorePage(storeId :  storeId),
      ),
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
