import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/assignment.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_room_repository.dart';
import 'package:things_game/cubit/state/game_room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class GameRoomCubit extends Cubit<GameRoomState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRoomRepository repo = GameRoomRepository();

  GameRoomCubit() : super(GameRoomInitial());

  void createRoom(
    ConfigurationData data,
  ) async {
    actualGame = actualGame.copyWith(
      numPlayers: data.players,
      numRounds: data.rounds,
      maxPoints: data.maxPoints,
      isPrivate: data.isPrivate,
    );

    const result = "https://pastebin.com/BjYFu9CW";
    // final result = await repo.createRoom(
    //   actualGame.toJson().toString(),
    // );

    if (result.startsWith("error")) {
      emit(GameRoomError(error: result));
    } else {
      actualGame.id = result.substring(
        result.lastIndexOf("/") + 1,
      );

      emit(GameRoomCreated(room: actualGame));
    }
  }

  void getOpenRooms() {
    //emit(LoadingGameList());
    emit(GameListLoaded());
    print("### cubit get open rooms ###");
  }

  int addPlayer(String name) {
    print("### cubit add player ###");
    return 0;
  }

  void startGame() {
    print("### cubit Game Started! ###");
  }

  void backToMain(BuildContext context) {
    print("### cubit back to main screen ###");
    Navigator.of(context).popUntil(
      (route) => route.settings.name == "/main",
    );
  }

  int sendMessage() {
    print("### cubit send message ###");
    return 0;
  }

  List<String> announceAnswers() {
    print("### cubit announce answers ###");
    return [];
  }

  void sendAssignments(Assignment assignment) {
    print("### cubit send assignments ###");
  }

  void deleteRoom() {
    print("### cubit delete room ###");
  }
}
