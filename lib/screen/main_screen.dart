import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/main_screen.i18n.dart';
import 'package:things_game/widget/styled/styled_button.dart';

import '../cubit/room_cubit.dart';
import '../widget/alert_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ExitAppDialog(context).show();
        return false;
      },
      child: Scaffold(
        backgroundColor: UserSettings.I.backgroundColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: _getDecoration("assets/background_main.png"),
          child: SafeArea(child: _getContent(context)),
        ),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final configPadding = Platform.isIOS ? 0.0 : 10.0;

    return Column(
      children: [
        // Config button
        // TODO: replace for Positioned ??
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(
              right: 65.0,
              top: configPadding,
            ),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/preferences")
                    .then((value) => setState(() {}));
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: _getDecoration("assets/config.png"),
              ),
            ),
          ),
        ),

        // App Logo
        SizedBox(
          height: screenSize.height * 0.20,
          width: screenSize.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/logo.png", scale: 3),
          ),
        ),

        // Empty space
        SizedBox(
          height: screenSize.height * 0.30,
          width: screenSize.width,
        ),

        // Create game button
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: StyledButton(
            text: "Create game".i18n,
            // onPressed: () => Navigator.of(context).pushNamed("/create"),
            onPressed: () => BlocProvider.of<RoomCubit>(context).addPlayer("manel"),
          ),
        ),

        // Join game button
        StyledButton(
          text: "Join game".i18n,
          onPressed: () => Navigator.of(context).pushNamed("/search"),
        ),
      ],
    );
  }

  BoxDecoration _getDecoration(String asset) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(asset),
        colorFilter: ColorFilter.mode(
          UserSettings.I.primaryColor,
          BlendMode.srcIn,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}
