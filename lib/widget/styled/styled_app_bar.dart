import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/config/user_settings.dart';

//ignore: must_be_immutable
class StyledAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  ValueNotifier<Color>? notifier;

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
    widget.notifier ??= ValueNotifier<Color>(
      UserSettings.instance.primaryColor,
    );

    widget.notifier!.addListener(() {
      debugPrint("### Updating color on StyledAppBar... ###");
      setState(() {});
    });

    return AppBar(
      backgroundColor: widget.notifier!.value,
      leading: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: StyledText(widget.title),
    );
  }
}
