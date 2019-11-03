import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k_pasar/data/network/ApiEndPoint.dart';
import 'package:k_pasar/model/Product.dart';

class ItemCard extends StatelessWidget {
  final ValueChanged<Product> onTap;

  MediaQueryData queryData;

  final Product product;

  // final String images;
  // final String storeName;
  // final int id;
  // final double price;
  // final String unit;
  // final String name;

  ItemCard(
      {Key key,
      this.onTap,
      // this.images,
      // this.price,
      // this.name,
      // this.id,
      // this.storeName,
      // this.unit, 
      this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imagesArr = this.product.images.split(";");
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    TextStyle style15Bold = new TextStyle(
      inherit: true,
      fontSize: 6 * devicePixelRatio,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    );
    TextStyle style15BoldWhite = new TextStyle(
      inherit: true,
      fontSize: 6 * devicePixelRatio,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 6 * devicePixelRatio,
      color: Colors.green,
    );
    var formatter = new NumberFormat.decimalPattern();
    return new Container(
      child: new Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            // debugPrint("$name");
            this.onTap( this.product );
          },
          child: new Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 80 * devicePixelRatio,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 60 * devicePixelRatio,
                        child: new Image.network(
                          '${ApiEndPoint.PRODUCT_IMAGE}/${imagesArr[0]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 60 * devicePixelRatio,
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
                        // bottom: 30 * devicePixelRatio,
                        bottom: 8.0,
                        left: 0.0,
                        right: 0.0,
                        child: Center(
                          child: Text(
                            "Rp. ${formatter.format(this.product.price)}/${this.product.unit}",
                            style: style15BoldWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    // bottom: 30 * devicePixelRatio,
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${this.product.name}",
                          style: style15Bold,
                        ),
                        Text(
                          "${this.product.storeName}",
                          style: style15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
