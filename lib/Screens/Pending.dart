import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ke_domain_connect/Components/MyAppBar.dart';
import 'package:ke_domain_connect/Components/MyEndDrawer.dart';

import '../Theme.dart';

class PendingStatusWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const PendingStatusWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(actions: false, backButton: true,title: 'Registrar Dashboard ',),
      endDrawer:  EndDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Icon(
                    Icons.error_outline,
                    size: 200,
                    color:Colors.red,
                ),
                SizedBox(height: 18),
                Text(
                  'Your Status is Pending',
                  style: CustomTheme.titleStyle,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Please wait while we update your  status\nfor any queries contact us',
                  textAlign: TextAlign.center,
                  style: CustomTheme.bodyStyle,
                ),
                const Text(
                  'phone: 0798302731\nemail: devann646@gmail.com',
                  textAlign: TextAlign.center,
                  style: CustomTheme.bodyStyle,
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      );
  }
}
