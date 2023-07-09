import 'package:flutter/material.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/screen/game_settings_screen.dart';
import 'package:things_game/screen/user_settings_screen.dart';
import 'package:things_game/translations/lobby_screen.i18n.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';

import '../config/user_settings.dart';

class LobbyScreen extends StatefulWidget {
  final GameRoom room;

  const LobbyScreen({
    super.key,
    required this.room,
  });

  @override
  State<StatefulWidget> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserSettings.I.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _getHeader(),
            _getListView(context),
            StyledButton(
              text: "Start/Ready".i18n,
              onPressed: () => print("### Game Started! ###"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: StyledButton(
                text: "Leave room".i18n,
                onPressed: () => print("### Leaving room... ###"),
                type: ButtonType.destructive,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    // TODO: center row with button on right.
    final title = "Lobby id".i18n;
    return Row(
      children: [
        StyledText(
          "$title: \n${widget.room.id}",
          fontSize: 30,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _getConfigButton(context),
        ),
      ],
    );
  }

  Widget _getListView(BuildContext context) {
    final cells = [
      UserSettings.I.name,
      "Player 1",
      "Player 2",
      "Player 3",
      "Rounds".i18n,
      "Max. points".i18n,
    ];

    // TODO: maybe separate listView players from rounds + maxpoints??
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: cells.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < cells.length - 2) {
                return ListTile(
                  leading: UserSettings.I.avatar,
                  title: StyledText(cells[index]),
                );
              }

              if (index == cells.length - 2) {
                return ListTile(
                  title: StyledText("Rounds".i18n),
                  trailing: StyledText(widget.room.numRounds.toString()),
                );
              }

              if (index == cells.length - 1) {
                return ListTile(
                  title: StyledText("Max. points".i18n),
                  trailing: StyledText(widget.room.maxPoints.toString()),
                );
              }

              return null;
            },
            separatorBuilder: (BuildContext context, int index) {
              if (index == cells.length - 2) {
                return const Divider(height: 1);
              }

              return const Divider(height: 0);
            },
          ),
        ),
      ),
    );
  }

  Widget _getConfigButton(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        // TODO: uncomment when game_settings_screen's fixme is done.
        // Navigator.of(context)
        //     .push(
        //       MaterialPageRoute(
        //         builder: (context) => GameSettingsScreen(),
        //       ),
        //     )
        //     .then(
        //       (value) => setState(() {}),
        //     );
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: _getDecoration(
          "assets/config.png",
        ),
      ),
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
