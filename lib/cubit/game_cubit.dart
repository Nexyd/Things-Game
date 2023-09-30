import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_room_repository.dart';
import 'package:things_game/cubit/state/game_state.dart';

import 'model/assignment.dart';

class GameCubit extends Cubit<GameState> {
  GameRoom actualGame = GameRoom.empty();
  // TODO: change to GameRepository ??
  final GameRoomRepository repo = GameRoomRepository();

  GameCubit() : super(GameInitial());

  void startGame() {
    print("### cubit Game Started! ###");
  }

  bool sendMessage() {
    print("### cubit send message ###");
    return false;
  }

  List<String> announceAnswers() {
    print("### cubit announce answers ###");
    return [];
  }

  bool sendAssignments(Assignment assignment) {
    print("### cubit send assignments ###");
    return false;
  }
}
