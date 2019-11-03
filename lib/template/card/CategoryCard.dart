import 'package:flutter/material.dart';
import 'package:k_pasar/model/Category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final ValueChanged<Category> onTap;

  MediaQueryData queryData;

  CategoryCard({Key key, this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 6 * devicePixelRatio,
      color: Colors.green,
    );
    return new Container(
      child: new Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            debugPrint("${category.name}");
            this.onTap( category );
            // Navigator.pushNamed(context, category.routeName );
          },
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: new Image.asset(
                  '${category.image}',
                  scale : 7 * devicePixelRatio,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: new Text(
                  category.name,
                  style: style15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
