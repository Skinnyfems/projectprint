import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'suplier_page.dart';
import 'material_page.dart';
import 'setting_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'MENU',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          buildDrawerItem(context, Icons.person, 'Profile', ProfilePage()),
          buildDrawerItem(context, Icons.business, 'Suplier', SuplierPage()),
          buildDrawerItem(context, Icons.inventory, 'Material', MaterialPag()),
          buildDrawerItem(context, Icons.settings, 'Setting', SettingPage()),
        ],
      ),
    );
  }

  Widget buildDrawerItem(
      BuildContext context, IconData icon, String title, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => page));
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
