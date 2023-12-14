import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/search_room_screen.i18n.dart';
import 'package:things_game/util/color_utils.dart';
import 'package:things_game/widget/alert_dialog.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/util/debouncer.dart';
import 'package:things_game/screen/lobby_screen.dart';

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
        TextStyle(color: UserSettings.I.textColor),
      ),
      leading: Icon(
        Icons.menu,
        color: UserSettings.I.textColor,
      ),
      trailing: [
        Icon(
          Icons.search,
          color: UserSettings.I.textColor,
        ),
      ],
      backgroundColor: MaterialStateProperty.all(
        UserSettings.I.backgroundColor.shade(20),
      ),
      onChanged: _filterResultsBy,
    );
  }

  Widget _getListGames(BuildContext context) {
    final cubit = BlocProvider.of<RoomCubit>(context);
    if (!isListInitialized) {
      cubit.getOpenRooms();
    }

    return BlocBuilder<RoomCubit, RoomState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is RoomError) {
          Future.delayed(const Duration(milliseconds: 200)).then(
            (value) => ErrorDialog(context).show(),
          );

          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: StyledButton(
                text: 'Retry'.i18n,
                onPressed: () => cubit.getOpenRooms(),
              ),
            ),
          );
        }

        if (state is LoadingGameList) {
          return const CircularProgressIndicator();
        }

        if (state is RoomListLoaded && !isListInitialized) {
          fullList.addAll(state.roomList);
          gameList = fullList.where((e) => !e.config.isPrivate).toList();
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
              onTap: () => navigateToLobby(gameList[index]),
              title: StyledText(
                gameList[index].config.name,
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
      },
    );
  }

  void _filterResultsBy(String value) {
    final debouncer = Debouncer(milliseconds: 800);
    debouncer.run(() {
      gameList = fullList.where((element) {
        bool result = true;
        bool foundById = false;

        if (element.id == value) {
          foundById = true;
          return true;
        }

        if (!foundById) {
          for (var character in value.characters) {
            result = element.config.name.indexOf(character) > 0;
            if (!result) return false;
          }
        }

        return result;
      }).toList();

      setState(() {});
    });
  }

  void navigateToLobby(GameRoom selectedRoom) {
    final cubit = BlocProvider.of<RoomCubit>(context);
    cubit.joinRoom(selectedRoom, UserSettings.I.name);

    Navigator.of(context).pushNamed(
      "/lobby",
      arguments: LobbyScreenArguments(selectedRoom),
    );
  }
}
