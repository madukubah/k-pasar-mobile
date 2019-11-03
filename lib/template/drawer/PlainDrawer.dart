
import 'package:k_pasar/data/preferences/AppPreferenceHelper.dart';
import 'package:k_pasar/template/drawer/Menu.dart';
import 'package:flutter/material.dart';

class PlainDrawer extends StatefulWidget {
  final ValueChanged<Menu> onTap;
  final List<Menu> menus;
  final bool isLoggedIn;

  const PlainDrawer({Key key, this.menus, this.onTap, this.isLoggedIn = false}) : super(key: key);

  @override
  _PlainDrawerState createState() =>
      _PlainDrawerState( );
}

class _PlainDrawerState extends State<PlainDrawer> {
  
  List<InkWell> listMenu = List();
  AppPreferenceHelper preferenceHelper = AppPreferenceHelper.getInstance();
  _createList() async {

    if( this.widget.isLoggedIn )
    {
       drawer = [
       new UserAccountsDrawerHeader(
              onDetailsPressed: (){
                this.widget.onTap( Menu(title: "Profil", routename: "/Profile") );
              } ,
              accountName: new Text( "${preferenceHelper.getCurrentUserName()}" ),
              accountEmail: new Text( "${preferenceHelper.getCurrentUserPhone()}" ),
              currentAccountPicture: 
              new InkWell(
                  onTap: () {
                    // widget.onTap( Menu() );
                  },
                  child: new CircleAvatar(
                  backgroundImage: new NetworkImage( "${preferenceHelper.getCurrentUserImage()}" ),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage("https://image.freepik.com/free-vector/abstract-colorful-pattern-shape-design-background_38782-954.jpg"),
                fit: BoxFit.cover
                )
              ),
            ),
        ];
    }
   

    for (var i = 0; i < this.widget.menus.length; i++) {
      listMenu.add(
        new InkWell(
          onTap: () {
            this.widget.onTap( this.widget.menus[i] );
          },
          child: new ListTile(
              title: new Text("${this.widget.menus[i].title}"),
              trailing: new Icon( this.widget.menus[i].icon ),
            ),
        ),
      );
    }

    Menu logout = Menu(title: "Keluar", routename: "/Logout", icon: Icons.arrow_right );
    listMenu.add(
        new InkWell(
          onTap: () {
            this.widget.onTap( logout );
          },
          child: new ListTile(
              title: new Text("${logout.title}"),
              trailing: new Icon( logout.icon ),
            ),
        ),
      );

    setState(() {
      drawer.addAll( listMenu );
    });
  }
  
  List<Widget> drawer = List();
  @override
  void initState() {
    this._createList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Drawer(
        child: new ListView(
          children:drawer,
        ),
      );
  }
}

