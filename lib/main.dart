import 'package:flutter/material.dart';
import 'package:k_pasar/activity/my_product/MyProduct.dart';
import 'package:k_pasar/activity/my_store/MyStore.dart';
import 'activity/auth/login/LoginPage.dart';
import 'activity/auth/register/RegisterPage.dart';
import 'activity/item_page/ItemPage.dart';
import 'activity/profile/Profile.dart';
import 'activity/splash/SplashScreen.dart';
import 'activity/main/Home.dart';
import 'activity/store_create/StoreCreate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutteCore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(  ) ,
        '/LoginPage': (BuildContext context) => new LoginPage(  ),
        '/RegisterPage': (BuildContext context) => new RegisterPage(  ),
        '/RegisterPage': (BuildContext context) => new RegisterPage(  ),
        '/Profile': (BuildContext context) => new Profile(  ),
        '/ItemPage': (BuildContext context) => new ItemPage(  ),
        '/MyProduct': (BuildContext context) => new MyProduct(  ),
        '/StoreCreate': (BuildContext context) => new StoreCreate(  ),
        '/MyStore': (BuildContext context) => new MyStore(  ),
      },
      onGenerateRoute : (settings) {
        
      }
    );
  }
}
