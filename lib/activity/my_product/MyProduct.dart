import 'package:k_pasar/activity/my_product/view/MyProductMVPView.dart';
import 'package:k_pasar/activity/product_add/ProductAdd.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';
import 'package:k_pasar/template/card/ItemCard.dart';

import 'package:k_pasar/util/AppConstants.dart';
import 'package:flutter/material.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/MyProductInteractor.dart';
import 'interactor/MyProductMVPInteractor.dart';
import 'presenter/MyProductPresenter.dart';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> implements MyProductMVPView {
  MyProductPresenter<MyProductMVPView, MyProductMVPInteractor> presenter;
  bool _isLoading = true;
  Store store;
  List<Product> products = List();

  _MyProductState() {
    MyProductInteractor interactor = MyProductInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = MyProductPresenter<MyProductMVPView, MyProductMVPInteractor>(
        interactor);
    this.presenter.onAttach(this);
  }

  @override
  void initState() {
    this.presenter.loadStoreByUserId();
    super.initState();
  }
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 8 * devicePixelRatio,
      color: Colors.green,
    );
    if (_isLoading)
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Produk Saya"),
          backgroundColor: AppColor.PRIMARY,
        ),
        body: new Center(
          child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    else
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Produk Saya"),
          backgroundColor: AppColor.PRIMARY,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              tooltip: 'Air it',
              onPressed: () {
                if( store == null )
                {
                  this.showDialogNotHaveStore();
                  return;
                }
                this.presenter.loadProductByUserId();
              },
            ),
          ],
        ),
        body: Container(
          child: (products.isEmpty)
              ? Center(
                  child: Text("Data tidak ada", style: style15),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      delegate: SliverChildListDelegate(
                        products.map((product) {
                          return Builder(builder: (BuildContext context) {
                            return ItemCard(
                              product: product,
                              onTap: (Product product) {
                                // this.goToDetailPage(product);
                              },
                            );
                          });
                        }).toList(),
                      ),
                    ),
                  ],
                ),
        ),
         floatingActionButton: FloatingActionButton(
          onPressed: (){
            this.goToProductAdd();
          } ,
          backgroundColor: Colors.green,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
  }

  @override
  void hideProgress() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showMessage(String message, int status) {
    // TODO: implement showMessage
  }

  @override
  void showProgress() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void onLoadProducts(List<Product> products, bool status) {
     setState(() {
      this.products = (products);
    });
  }

  void goToProductAdd() {
    print("goToProductAdd");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductAdd(),
      ),
    );
  }

  @override
  Future<void> showDialogNotHaveStore() {
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Belum Punya Usaha'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Silahkan membuat usaha terlebih dahulu'),
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
              Navigator.pushReplacementNamed(context, '/StoreCreate');
            },
          ),
        ],
      );
    },
  );
  }

  @override
  void onLoadStore(Store store) {
    this.store = store;
  }
}