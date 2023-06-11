import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/state/game_room_state.dart';
import 'package:things_game/translations/search_room_screen.i18n.dart';
import 'package:things_game/util/color_utils.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_text.dart';

import '../cubit/game_room_cubit.dart';

class SearchRoomScreen extends StatelessWidget {
  // TODO: change String to GameRoomData
  List<String> gameList = [];

  SearchRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listTitle = "Open games".i18n;

    return Scaffold(
      appBar: StyledAppBar("Search room".i18n),
      backgroundColor: UserSettings.instance.backgroundColor,
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search game
            _getSearchBar(context),

            // List title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
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
          color: UserSettings.instance.textColor,
        ),
      ),
      leading: Icon(
        Icons.menu,
        color: UserSettings.instance.textColor,
      ),
      trailing: [
        Icon(
          Icons.search,
          color: UserSettings.instance.textColor,
        )
      ],
      backgroundColor: MaterialStateProperty.all(
        UserSettings.instance.backgroundColor.shade(20),
      ),
      onChanged: _filterResultsBy,
    );
  }

  Widget _getListGames(BuildContext context) {
    final cubit = BlocProvider.of<GameRoomCubit>(context);
    cubit.getOpenRooms();

    return BlocBuilder<GameRoomCubit, GameRoomState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GameRoomError) {
          // TODO: show error message.
          return Container();
        }

        if (state is LoadingGameList) {
          return const CircularProgressIndicator();
        }

        if (state is GameListLoaded) {
          // gameList = state.gameList;
          // gameList.add("value1");
          // gameList.add("value2");
          // gameList.add("value2");

          if (gameList.isEmpty) {
            return StyledText(
              "No games available".i18n,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            );
          }

          return ListView.separated(
            itemCount: gameList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: StyledText(
                  // TODO: change to gameList[index].name,
                  gameList[index],
                  fontSize: 20,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
                color: UserSettings.instance.textColor,
              );
            },
          );
        }

        return Container();
      },
    );
  }

  void _filterResultsBy(String value) {
    print("### search value: $value ###");
    // TODO: filter game list by search value
    // TODO: compare with GameRoomData.id
    // TODO: filter id.contains(value) with regEx?
    // TODO: add debouncer
  }
}
