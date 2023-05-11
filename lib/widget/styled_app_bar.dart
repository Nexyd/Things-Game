import 'package:flutter/material.dart';

import '../config/user_settings.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const StyledAppBar(this.title, {super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super();

  @override
  final Size preferredSize; // 56.0 by default.

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: UserSettings.instance.primaryColor,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: UserSettings.instance.textColor,
        ),
      ),
    );
  }
}