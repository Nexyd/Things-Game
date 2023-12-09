import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_repository.dart';
import 'package:things_game/cubit/state/game_state.dart';

import 'model/assignment.dart';

class GameCubit extends Cubit<GameState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRepository repo = GameRepository();

  GameCubit() : super(GameInitial());

  Future<void> startGame() async {
    print("### game cubit Game Started! ###");
    // TODO: create board in firestore
  }

  Future<bool> sendMessage() async {
    print("### game cubit send message ###");
    return false;
  }

  Future<List<String>> announceAnswers() async {
    print("### game cubit announce answers ###");
    return [];
  }

  Future<bool> sendAssignments(Assignment assignment) async {
    print("### game cubit send assignments ###");
    return false;
  }
}
