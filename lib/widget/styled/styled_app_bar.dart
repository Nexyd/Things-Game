import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/config/user_settings.dart';

//ignore: must_be_immutable
class StyledAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  ValueNotifier<Color>? colorNotifier;
  ValueNotifier<String>? titleNotifier;

  StyledAppBar(
    this.title, {
    super.key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super();

  @override
  final Size preferredSize; // 56.0 by default.

  @override
  State<StyledAppBar> createState() => _StyledAppBarState();
}

class _StyledAppBarState extends State<StyledAppBar> {
  @override
  Widget build(BuildContext context) {
    _initNotifiers();

    return AppBar(
      backgroundColor: widget.colorNotifier!.value,
      leading: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: StyledText(widget.titleNotifier!.value),
    );
  }

  void _initNotifiers() {
    widget.colorNotifier ??= ValueNotifier<Color>(
      UserSettings.I.primaryColor,
    );

    widget.colorNotifier!.addListener(() {
      print("### Updating color on StyledAppBar... ###");
      setState(() {});
    });

    widget.titleNotifier ??= ValueNotifier<String>(widget.title);
    widget.titleNotifier!.addListener(() {
      print("### Updating title on StyledAppBar... ###");
      setState(() {});
    });
  }
}
