import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Auth/Login.dart';
import 'package:ke_domain_connect/Screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NetworkUtils/api.dart';
import '../Screens/ManageAccount.dart';
import '../Screens/RegistrarDashboard.dart';
import '../Theme.dart';



class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  var user;
  bool hasFacility = false;
  bool hasAffiliate = false;
  bool hasDoctor = false;



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    void logout() async {
      var res = await Network().getData('/logout');
      json.decode(res.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/login", (Route route) => false);
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                if (user != null)
                  CachedNetworkImage(
                    imageUrl: user['image'] ?? '',
                    // Replace with your image URL
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundImage: AssetImage('assets/img/logo.png'),
                      radius: 30.0,
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    // You can customize this
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 30.0,
                    ),
                  ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (user != null && user['name'] != null)
                        Text(
                          user['name']!,
                          style: CustomTheme.titleStyle,
                        ),
                      if (user != null && user['email'] != null)
                        Text(
                          user['email']!,
                          style: CustomTheme.bodyStyle,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              if (hasAffiliate) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrarCustomersScreen()));
              } else  (hasFacility) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
              };
            },
          ),


              // Fluttertoast.showToast(
              //     msg: "Ooops! Feature coming soon.",
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.TOP,
              //     textColor: Colors.white,
              //     fontSize: 16.0);


          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Manage Account',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageAccountScreen()),
              );
            },
          ),



          _buildDrawerItem(
            icon: Icons.person,
            text: 'Registrar Dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>RegistrarCustomersScreen ()),
              );
            },
          ),

          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFFF15E33),
      ),
      title: Text(text, style: CustomTheme.bodyStyle),
      onTap: onTap,
    );
  }
}
