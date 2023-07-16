import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_room_repository.dart';
import 'package:things_game/cubit/state/game_room_state.dart';
import 'package:things_game/cubit/state/game_settings_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import 'model/assignment.dart';

class GameRoomCubit extends Cubit<GameRoomState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRoomRepository repo = GameRoomRepository();

  GameRoomCubit() : super(GameRoomInitial());

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

  void deleteRoom() {
    print("### cubit delete room ###");
  }
}
