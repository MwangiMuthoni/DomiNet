
import 'package:flutter/material.dart';

import '../theme.dart' show CustomTheme;

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final bool actions;
  final String? title;
  final Widget? customTitle;

  const MyAppBar({
    super.key,
    this.title,
    required this.actions,
    required this.backButton,

    this.customTitle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    super.initState();
    _asyncFunctions();
  }

  Future<void> _asyncFunctions() async {}

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: widget.backButton,
      iconTheme: const IconThemeData(color: Colors.red),
      title:
      widget.customTitle ??
          Row(
            children: [
              if (widget.title == null)
                Image.asset('assets/img/logo.png', height: 60),
              if (widget.title != null)
                Expanded(
                  child: Text(
                    widget.title ?? '',
                    style: CustomTheme.titleStyle,
                  ),
                ),
              const SizedBox(width: 10),
            ],
          ),

    );
  }
}
