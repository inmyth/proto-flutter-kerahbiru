import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/routes.dart';



class AppDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final currentPage = ModalRoute.of(context).settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.perm_identity,
              text: 'App : Worker version',
              onTap: () =>
              currentPage == Routes.profile ? null : Navigator.pushReplacementNamed(context, Routes.profile)),
          _createDrawerItem(
              icon: Icons.auto_stories,
              text: 'App : Company version',
              onTap: () => currentPage == Routes.company ? null : Navigator.pushReplacementNamed(context, Routes.company)),
          _createDrawerItem(
              icon: Icons.article_outlined,
              text: 'Certificate',
              onTap: () =>
              currentPage == Routes.certificate ? null : Navigator.pushReplacementNamed(context, Routes.certificate)),
          ListTile(
            title: Text('0.0.2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/drawer_head.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Kerah Biru Flutter Demo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}