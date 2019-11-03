import 'package:intl/intl.dart';
import 'package:k_pasar/activity/my_store/view/MyStoreMVPView.dart';
import 'package:k_pasar/activity/store_create/StoreCreate.dart';
import 'package:k_pasar/model/Gallery.dart';
import 'package:k_pasar/model/Product.dart';
import 'package:k_pasar/model/Store.dart';
import 'package:k_pasar/template/card/ItemCard.dart';
import 'package:k_pasar/util/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/MyStoreInteractor.dart';
import 'interactor/MyStoreMVPInteractor.dart';
import 'presenter/MyStorePresenter.dart';

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore>
    with TickerProviderStateMixin
    implements MyStoreMVPView {
  MyStorePresenter<MyStoreMVPView, MyStoreMVPInteractor> presenter;
  Store store = new Store();
  bool _isLoading = true;
  List<Product> products = List();
  List<Gallery> galleries = List();
  TabController _tabController;

  _MyStoreState() {
    MyStoreInteractor interactor = MyStoreInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter =
        MyStorePresenter<MyStoreMVPView, MyStoreMVPInteractor>(interactor);
    this.presenter.onAttach(this);
  }

  @override
  void initState() {
    this.presenter.loadStoreByUserId();
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
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
        appBar: new AppBar(
          title: new Text("Usaha Saya"),
          backgroundColor: AppColor.PRIMARY,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              tooltip: 'Air it',
              onPressed: () {
                if (store == null) {
                  this.showDialogNotHaveStore();
                  return;
                }
                this.presenter.loadStoreByUserId();
              },
            ),
          ],
        ),
        body: CustomScrollView(
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
                            width: MediaQuery.of(context).size.width * (2 / 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundImage: NetworkImage('${store.userImage}'),
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
                              width:
                                  MediaQuery.of(context).size.width * (8 / 10),
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
                          child: Text('${store.description}', style: style15),
                        ),
                        Center(
                              child:FlatButton(
                                child: Icon(Icons.edit, color: Colors.white,),
                                color: Colors.green,
                                onPressed: () {
                                  print("editStore");
                                  editStore( context );
                                },
                              ),
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
                              height: MediaQuery.of(context).devicePixelRatio *
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
                                                  onTap: (Product product) {
                                                    // this.goToDetailPage(
                                                    //     product);
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
                                                .map((i, gallery) => MapEntry(
                                                    i,
                                                    InkWell(
                                                      onTap: () =>
                                                          this.viewPhoto(i),
                                                      child: Card(
                                                          child: Image.network(
                                                        "${gallery.images}",
                                                        fit: BoxFit.cover,
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: AppColor.PRIMARY,
        //   tooltip: 'Increment',
        //   child: Icon(Icons.edit),
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
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok', style: TextStyle(color: AppColor.PRIMARY)),
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

  void editStore( BuildContext context ) async  {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoreCreate(editMode :  true, store : this.store ),
      ),
    );

    // Scaffold.of(context)
    //   ..showSnackBar(SnackBar(content: Text("$result")));
    this.presenter.loadStoreByUserId();
  }
  
  @override
  void onLoadStore(Store store) {
    this.store = store;
  }

  @override
  void onLoadGalleries(List<Gallery> galleries) {
    setState(() {
      this.galleries = (galleries);
    });
  }

  @override
  void onLoadProducts(List<Product> products) {
    setState(() {
      this.products = (products);
    });
  }
}
