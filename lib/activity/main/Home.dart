import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:k_pasar/activity/item_page/ItemPage.dart';
import 'package:k_pasar/activity/main/presenter/HomePresenter.dart';
import 'package:k_pasar/activity/main/view/HomeMVPView.dart';
import 'package:k_pasar/data/network/AppApiHelper.dart';
import 'package:k_pasar/data/preferences/AppPreferenceHelper.dart';
import 'package:k_pasar/model/Adverticement.dart';
import 'package:k_pasar/model/Category.dart';
import 'package:k_pasar/template/card/CategoryCard.dart';
import 'package:k_pasar/template/drawer/Menu.dart';
import 'package:k_pasar/template/drawer/PlainDrawer.dart';
import 'package:k_pasar/util/AppConstants.dart';
import 'package:flutter/material.dart';

import 'interactor/HomeInteractor.dart';
import 'interactor/HomeMVPInteractor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements HomeMVPView {
  MediaQueryData queryData;

  HomePresenter<HomeMVPView, HomeMVPInteractor> presenter;
  bool isLoggedIn = false;
  int _current = 0;
  _HomeState() {
    HomeInteractor interactor = HomeInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = HomePresenter<HomeMVPView, HomeMVPInteractor>(interactor);
    this.presenter.onAttach(this);
  }
  @override
  void initState() {
    this.presenter.start();
    super.initState();
  }

  Widget slider = null;
  List<Adverticement> adverticements = List();
  List<Menu> menus = [
    Menu(title: "Usaha Saya", routename: "/MyStore"),
    Menu(title: "Produk Saya", routename: "/MyProduct"),
    Menu(title: "Galeri", routename: "/Profile"),
    Menu(title: "Pengaturan", routename: "/Profile"),
  ];

  var _categories = [
    {
      "id": "104",
      "image": 'assets/images/farm.png',
      "name": "Pertanian",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "105",
      "image": 'assets/images/vegetables.png',
      "name": "Perkebunan",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "117",
      "image": 'assets/images/seed.png',
      "name": "Bibit",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "106",
      "image": 'assets/images/barn.png',
      "name": "Peternakan",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "107",
      "image": 'assets/images/hydrophonic.png',
      "name": "Hidroponik",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "108",
      "image": 'assets/images/organic.png',
      "name": "Organik",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "110",
      "image": 'assets/images/suplier.png',
      "name": "Pupuk",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "111",
      "image": 'assets/images/machine.png',
      "name": "Mesin",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "114",
      "image": 'assets/images/transporter.png',
      "name": "Transporter",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
    {
      "id": "1",
      "image": 'assets/images/contact-us.png',
      "name": "Investasi",
      "iconColor": Colors.grey,
      "routeName": '/ItemPage'
    },
  ];

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${AppConstants.APP_NAME}"),
        backgroundColor: AppColor.PRIMARY,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Air it',
            onPressed: () {},
          ),
        ],
      ),
      drawer: new PlainDrawer(
              isLoggedIn : this.isLoggedIn,
              menus: menus,
              onTap: (Menu menu) {
                print(menu.routename);
                if (menu.routename == "/LoginPage") 
                {
                  Navigator.pop(context);
                  this.toLoginPage();
                }
                if (menu.routename == "/Logout") {
                  Navigator.pop(context);
                  this.presenter.logout();
                } else
                  Navigator.of(context).pushNamed(menu.routename);
              },
            ),
      body: Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        (adverticements.isEmpty)
                            ? Container()
                            : Stack(
                                children: [
                                  CarouselSlider(
                                    onPageChanged: (index) {
                                      setState(() {
                                        _current = index;
                                      });
                                    },
                                    autoPlay: true,
                                    viewportFraction: 1.0,
                                    aspectRatio:
                                        MediaQuery.of(context).size.aspectRatio,
                                    // autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 5),
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    items: adverticements.map((adverticement) {
                                      return Builder(
                                          builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.amber),
                                          child: new Image.network(
                                            adverticement.images,
                                            width: 1000.0,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                40,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      });
                                    }).toList(),
                                  ),
                                  Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: adverticements.map((i) {
                                          return Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 2.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _current == i
                                                    ? Color.fromRGBO(
                                                        0, 0, 0, 0.9)
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 0.4)),
                                          );
                                        }).toList(),
                                      )),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Kategori",
                            style: TextStyle(
                              color: AppColor.PRIMARY,
                              fontSize: 7 * devicePixelRatio,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    delegate:
                        SliverChildListDelegate(_categories.map((category) {
                      return Builder(builder: (BuildContext context) {
                        return CategoryCard(
                          category: Category.fromMap(category),
                          onTap: (Category category) {
                            this.toItemPage( category ) ; //TO ITEM PAGE
                          },
                        );
                      });
                    }).toList()),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Produk Populer",
                            style: TextStyle(
                              color: AppColor.PRIMARY,
                              fontSize: 7 * devicePixelRatio,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CarouselSlider(
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 5),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  debugPrint("tap");
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.amber),
                                          child: new Image.asset(
                                            'assets/images/sapi.jpg',
                                            width: 1000.0,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 50.0,
                                        left: 20.0,
                                        right: 0.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Sapi Greget 120 KG",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        7 * devicePixelRatio,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Harga Terjangkau",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        6 * devicePixelRatio,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            });
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Artikel",
                            style: TextStyle(
                              color: AppColor.PRIMARY,
                              fontSize: 7 * devicePixelRatio,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [1, 2, 3, 4, 5].map((i) {
                            return Builder(builder: (BuildContext context) {
                              return ListTile(
                                onTap: () {
                                  print("tap");
                                },
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/sapi.jpg"), // no matter how big it is, it won't overflow
                                ),
                                title: Text("Cara merawat sapi dengan baik"),
                                subtitle: Text(
                                    "Cara merawat sapi dengan baik Cara merawat sapi dengan baik Cara merawat sapi dengan baik"),
                              );
                            });
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toItemPage(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ItemPage(category: category),
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
  void toLoginPage() {
    Navigator.of(context).pushReplacementNamed("/LoginPage");
  }

  @override
  void onIsUserLogin(bool isLoggedIn) {
    setState(() {
      // this.isLoggedIn = true;
      this.isLoggedIn = isLoggedIn;
      if( !isLoggedIn )
      {
        this.menus = [
          Menu(title: "Login / Register", routename: "/LoginPage"),
        ];
      }
    });
  }

  @override
  void onLoadAdverticement(List<Adverticement> adverticements) {
    setState(() {
      this.adverticements = adverticements;
    });
  }
}
