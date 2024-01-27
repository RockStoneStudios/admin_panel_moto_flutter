import 'package:adminpanel/pages/drivers_page.dart';
import 'package:adminpanel/pages/trips_page.dart';
import 'package:adminpanel/pages/users_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'dashboard.dart';

class SideNavigationDrawer extends StatefulWidget {
  const SideNavigationDrawer({super.key});

  @override
  State<SideNavigationDrawer> createState() => _SideNavigationDrawerState();
}

class _SideNavigationDrawerState extends State<SideNavigationDrawer> {
  Widget choosenScreen = Dashboard();
  sendAdminTo(selectedPage) {
    switch (selectedPage.route) {
      case DriversPage.id:
        setState(() {
          choosenScreen = DriversPage();
        });
        break;
      case UsersPage.id:
        setState(() {
          choosenScreen = UsersPage();
        });
        break;
      case TripsPage.id:
        setState(() {
          choosenScreen = TripsPage();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade700,
        title: const Text(
          'Admin Web Panel',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
              title: "Drivers",
              route: DriversPage.id,
              icon: CupertinoIcons.car_detailed),
          AdminMenuItem(
              title: "Users",
              route: UsersPage.id,
              icon: CupertinoIcons.person_2_fill),
          AdminMenuItem(
              title: "Trips",
              route: TripsPage.id,
              icon: CupertinoIcons.graph_square)
        ],
        selectedRoute: DriversPage.id,
        onSelected: (selectePage) {
          sendAdminTo(selectePage);
        },
        header: Container(
          height: 52,
          width: double.infinity,
          color: Colors.pinkAccent.shade700,
          child: const Row(
            children: [
              Icon(
                Icons.accessibility,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
              )
            ],
          ),
        ),
        footer: Container(
          height: 52,
          width: double.infinity,
          color: Colors.pinkAccent.shade700,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.computer,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      body: choosenScreen,
    );
  }
}
