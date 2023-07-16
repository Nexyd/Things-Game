import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/state/game_room_state.dart';
import 'package:things_game/cubit/state/game_settings_state.dart';
import 'package:things_game/translations/search_room_screen.i18n.dart';
import 'package:things_game/util/color_utils.dart';
import 'package:things_game/widget/alert_dialog.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/cubit/game_settings_cubit.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/util/debouncer.dart';


class SearchRoomScreen extends StatefulWidget {
  const SearchRoomScreen({super.key});

  @override
  State<SearchRoomScreen> createState() => _SearchRoomScreenState();
}

class _SearchRoomScreenState extends State<SearchRoomScreen> {
  bool isListInitialized = false;
  List<GameRoom> gameList = [];
  final List<GameRoom> fullList = [];

  @override
  Widget build(BuildContext context) {
    final listTitle = "Open games".i18n;

    return Scaffold(
      appBar: StyledAppBar("Search room".i18n),
      backgroundColor: UserSettings.I.backgroundColor,
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search game
            _getSearchBar(context),

            // List title
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: StyledText("- $listTitle -", fontSize: 25),
            ),

            // Game list
            Container(child: _getListGames(context))
          ],
        ),
      ),
    );
  }

  Widget _getSearchBar(BuildContext context) {
    return SearchBar(
      hintText: "Room id".i18n,
      textStyle: MaterialStateProperty.all(
        TextStyle(
          color: UserSettings.I.textColor,
        ),
      ),
      leading: Icon(
        Icons.menu,
        color: UserSettings.I.textColor,
      ),
      trailing: [
        Icon(
          Icons.search,
          color: UserSettings.I.textColor,
        )
      ],
      backgroundColor: MaterialStateProperty.all(
        UserSettings.I.backgroundColor.shade(20),
      ),
      onChanged: _filterResultsBy,
    );
  }

  Widget _getListGames(BuildContext context) {
    final cubit = BlocProvider.of<GameSettingsCubit>(context);
    if (!isListInitialized) {
      cubit.getOpenRooms();
    }

    return BlocBuilder<GameSettingsCubit, GameSettingsState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GameRoomError) {
          ErrorDialog(context).show();
          return Center(
            child: StyledButton(
              text: 'Retry'.i18n,
              onPressed: () => cubit.getOpenRooms(),
            ),
          );
        }

        if (state is LoadingGameList) {
          return const CircularProgressIndicator();
        }

        if (state is GameListLoaded) {
          if (!isListInitialized) {
            // TODO: get real room list.
            fullList.addAll(state.gameList);
            gameList = fullList;
            isListInitialized = true;
          }

          if (gameList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: StyledText(
                "No games available".i18n,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            itemCount: gameList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: StyledText(
                  gameList[index].name,
                  fontSize: 20,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
                color: UserSettings.I.textColor,
              );
            },
          );
        }

        return Container();
      },
    );
  }

  void _filterResultsBy(String value) {
    final debouncer = Debouncer(milliseconds: 500);
    debouncer.run(() {
      gameList = fullList.where((element) {
        bool result = true;
        for (var character in value.characters) {
          result = element.name.indexOf(character) > 0;
          if (!result) return false;
        }

        return result;
      }).toList();

      setState(() {});
    });
  }
}
