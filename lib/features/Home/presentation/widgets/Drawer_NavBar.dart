import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intrazero/core/helper/cashe_helper.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/core/service/service_locter.dart';

class DrawerNavBar extends StatelessWidget {
  DrawerNavBar({super.key});
  String? email = getIt<CacheHelper>().getData(
        key: "Email",
      ) ??
      "Invalid Email";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var name;
    if (user != null) {
      final name = user.displayName;
    }
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${name ?? 'Guest'}"),
            accountEmail: Text("$email"),
            decoration: BoxDecoration(
              color: Color(0xFF2A4BA0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.cartShopping),
            title: Text("Cart"),
            onTap: () {
              customNavigate(context, "/cart");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              customReplacementNavigate(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
