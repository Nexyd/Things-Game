import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_repository.dart';
import 'package:things_game/cubit/state/game_state.dart';

import 'model/assignment.dart';

class GameCubit extends Cubit<GameState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRepository repo = GameRepository();

  GameCubit() : super(GameInitial());

  void startGame() {
    print("### cubit Game Started! ###");
    // TODO: create board in firestore
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
