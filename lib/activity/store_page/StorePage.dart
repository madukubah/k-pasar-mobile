import 'package:intl/intl.dart';
import 'package:k_pasar/activity/detail_page/DetailPage.dart';
import 'package:k_pasar/activity/store_page/view/StoreMVPView.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';
import 'package:flutter/material.dart';
import 'package:k_pasar/template/card/ItemCard.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/StoreInteractor.dart';
import 'interactor/StoreMVPInteractor.dart';
import 'presenter/StorePresenter.dart';

class StorePage extends StatefulWidget {
  final int storeId;

  const StorePage({Key key, this.storeId}) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with TickerProviderStateMixin
    implements StoreMVPView {
  StorePresenter<StoreMVPView, StoreMVPInteractor> presenter;
  bool _isLoading = true;
  Store store = new Store();
  List<Product> products = List();
  List<Gallery> galleries = List();

  _StorePageState() {
    StoreInteractor interactor = StoreInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = StorePresenter<StoreMVPView, StoreMVPInteractor>(interactor);
    this.presenter.onAttach(this);
  }

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    this.presenter.loadStoreDetail(this.widget.storeId);
    _tabController = new TabController(vsync: this, length: 2);
  }

  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {

    var date = new DateTime.fromMillisecondsSinceEpoch(store.startDate * 1000);

    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    TextStyle style15BoldWhite = new TextStyle(
      inherit: true,
      fontSize: 13 * devicePixelRatio,
      color: Colors.white,
    );
    TextStyle style15White = new TextStyle(
      inherit: true,
      fontSize: 10 * devicePixelRatio,
      color: Colors.white,
    );
    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 8 * devicePixelRatio,
      color: Colors.black,
    );
    if (_isLoading)
      return new Scaffold(
        body: new Center(
          child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    else
      return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                child: new Image.network(
                                  '${store.images}',
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
                                    const Color(0x00000000),
                                    const Color(0x00000000),
                                    const Color(0xCC000000),
                                    const Color(0xCC000000),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10,
                              child: Container(
                                  // color: Colors.pink,
                                  height: 100.0,
                                  width: MediaQuery.of(context).size.width *
                                      (2 / 3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${store.name}',
                                        style: style15BoldWhite,
                                      ),
                                      Text(
                                        '${store.userFullname}',
                                        style: style15White,
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                              right: 10.0,
                              bottom: 10.0,
                              child: Container(
                                height: 100.0,
                                width: 100.0,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage('${store.userImage}'),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Icon(Icons.date_range),
                                    color: Colors.green,
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Berdiri Sejak ${DateFormat("dd-MM-yyyy").format(date)}",
                                    style: style15,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Icon(Icons.location_on),
                                    color: Colors.green,
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        (8 / 10),
                                    child: Text(
                                      '${store.address}',
                                      style: style15,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${store.description}',
                                    style: style15),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    decoration:
                                        new BoxDecoration(color: Colors.green),
                                    child: new TabBar(
                                        controller: _tabController,
                                        indicatorColor: Colors.lightGreen,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        tabs: [
                                          Tab(text: "Produk"),
                                          Tab(text: "Galeri"),
                                        ]),
                                  ),
                                  new Container(
                                    height: MediaQuery.of(context)
                                            .devicePixelRatio *
                                        100 *
                                        (products.length + 1) /
                                        2,
                                    child: new TabBarView(
                                      controller: _tabController,
                                      children: [
                                        Container(
                                          child: GridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            children: (products.isEmpty)
                                                ? [Container()]
                                                : products.map((product) {
                                                    return Builder(builder:
                                                        (BuildContext context) {
                                                      return ItemCard(
                                                        product: product,
                                                        onTap:
                                                            (Product product) {
                                                          this.goToDetailPage(
                                                              product);
                                                        },
                                                      );
                                                    });
                                                  }).toList(),
                                          ),
                                        ),
                                        Container(
                                          child: GridView.count(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              crossAxisCount: 3,
                                              children: (galleries.isEmpty)
                                                  ? [Container()]
                                                  : galleries
                                                      .asMap()
                                                      .map((i, gallery) =>
                                                          MapEntry(
                                                              i,
                                                              InkWell(
                                                                onTap: () => this
                                                                    .viewPhoto(
                                                                        i),
                                                                child: Card(
                                                                    child: Image
                                                                        .network(
                                                                  "${gallery.images}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                              )))
                                                      .values
                                                      .toList()),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: Colors.green,
        //   tooltip: 'Increment',
        //   child: Icon(Icons.shopping_cart),
        // ),
      );
  }

  viewPhoto(int i) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => Container(
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(galleries[index].images),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                // heroTag: galleryItems[index].id,
              );
            },
            pageController: new PageController(initialPage: i),
            itemCount: galleries.length,
          ),
        ),
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

  @override
  void onLoadStore(Store store, bool status) {
    if (status) {
      this.presenter.loadProductByUserId(store.userId);
      this.presenter.loadGalleryByUserId(store.userId);
    }
    setState(() {
      _isLoading = !status;
      this.store = store;
      // this.products.addAll(products);
    });
  }

  @override
  void onLoadProducts(List<Product> products, bool status) {
    setState(() {
      this.products.addAll(products);
    });
  }

  void goToDetailPage(Product product) {
    // print("$itemId");
    Navigator.pop(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(product: product),
      ),
    );
  }

  @override
  void onLoadGalleries(List<Gallery> galleries) {
    setState(() {
      this.galleries.addAll(galleries);
    });
  }
}
