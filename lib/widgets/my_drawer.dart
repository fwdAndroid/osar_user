import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: ListView(
        children: [
          ListTile(
            title: Text("Owner Account"),
            subtitle: Text("fwdkaleem@gmail.com"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account Information"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.border_outer_rounded),
            title: Text("Order History"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Payment Setting"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      )),
    );
  }
}
