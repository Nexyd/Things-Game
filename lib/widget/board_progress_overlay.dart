import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/support/logger.dart';

const _TAG = "[BoardProgressOverlay] ";

class BoardProgressOverlay extends StatelessWidget {
  final Widget child;
  final Color? color;

  const BoardProgressOverlay({
    super.key,
    required this.child,
    this.color,
  });

  static void toggle(BuildContext context) {
    Logger.global.debug("$_TAG toggling overlay...");
    _tryGetController(context)?.toggle();
  }

  static void show(BuildContext context) {
    Logger.global.debug("$_TAG showing overlay...");
    _tryGetController(context)?.show();
  }

  static void hide(BuildContext context) {
    Logger.global.debug("$_TAG hiding overlay...");
    _tryGetController(context)?.hide();
  }

  static OverlayPortalController? _tryGetController(BuildContext context) {
    try {
      return context.read<OverlayPortalController>();
    } catch (error) {
      Logger.global.debug("$_TAG no overlay controller found on context...");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _tryGetController(context);
    if (controller == null) return child;

    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) => _buildOverlay(context),
      child: child,
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final progressWidget = Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );

    return Column(children: [
      Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: color ?? const Color(0x99000000),
          child: Center(child: Scaffold(body: progressWidget)),
        ),
      ),
    ]);
  }
}
