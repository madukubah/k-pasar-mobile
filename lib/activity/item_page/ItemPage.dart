import 'package:k_pasar/activity/detail_page/DetailPage.dart';
import 'package:k_pasar/activity/item_page/interactor/ItemInteractor.dart';
import 'package:k_pasar/activity/item_page/presenter/ItemPresenter.dart';
import 'package:k_pasar/activity/item_page/view/ItemMVPView.dart';
import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/template/card/ItemCard.dart';
import 'package:k_pasar/template/drawer/Menu.dart';
import 'package:k_pasar/util/AppConstants.dart';
import 'package:flutter/material.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/ItemMVPInteractor.dart';

class ItemPage extends StatefulWidget {
  final Category category;

  const ItemPage({Key key, this.category}) : super(key: key);
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> implements ItemMVPView {
  List<Product> products = List();
  bool _isLoading = true;
  ItemPresenter<ItemMVPView, ItemMVPInteractor> presenter;
  _ItemPageState() {
    ItemInteractor interactor = ItemInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = ItemPresenter<ItemMVPView, ItemMVPInteractor>(interactor);
    this.presenter.onAttach(this);
  }

  List<Menu> menus = [
    Menu(title: "Usaha Saya", routename: "/Profile"),
    Menu(title: "Produk Saya", routename: "/Profile"),
    Menu(title: "Galeri", routename: "/Profile"),
    Menu(title: "Pengaturan", routename: "/Profile"),
  ];
  @override
  void initState() {
    this.presenter.loadProductByCategoryId(categoryId: widget.category.id);
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
    // print("${widget.category.id}");

    if (_isLoading)
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("${widget.category.name}"),
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
          title: new Text("${widget.category.name}"),
          backgroundColor: AppColor.PRIMARY,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              tooltip: 'Air it',
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.filter_list),
              tooltip: 'Air it',
              onPressed: () {},
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
                                this.goToDetailPage(product);
                              },
                            );
                          });
                        }).toList(),
                      ),
                    ),
                  ],
                ),
        ),
      );
  }

  void goToDetailPage(Product product) {
    // print("$itemId");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(product: product),
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
  void onLoadItem(List<Product> products, int status) {
    setState(() {
      _isLoading = !(status == 1);
      this.products.addAll(products);
    });
  }
}
