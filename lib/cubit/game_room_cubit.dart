import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/assignment.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_room_repository.dart';
import 'package:things_game/cubit/state/game_room_state.dart';
import 'package:things_game/widget/game_settings.dart';

class GameRoomCubit extends Cubit<GameRoomState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRoomRepository repo = GameRoomRepository();

  GameRoomCubit() : super(GameRoomInitial());

  void createRoom(
    ConfigurationData data,
  ) async {
    print("### cubit create room ###");
    print(
      "### room data - "
      "players: ${data.players}, "
      "rounds: ${data.rounds}, "
      "points: ${data.maxPoints}, "
      "isPrivate: ${data.isPrivate} "
      "###",
    );

    actualGame = actualGame.copyWith(
      numPlayers: data.players,
      numRounds: data.rounds,
      maxPoints: data.maxPoints,
      isPrivate: data.isPrivate,
    );

    print("### printing game json... ###");
    print("### ${actualGame.toJson()} ###");

    final result = await repo.createRoom(
      actualGame.toJson().toString(),
    );

    if (result.startsWith("error")) {
      emit(GameRoomError());
    } else {
      print("### game id: $result ###");
      actualGame.id = result;
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
