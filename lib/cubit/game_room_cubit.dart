import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/assignment.dart';
import 'package:things_game/cubit/state/game_room_state.dart';
import 'package:things_game/widget/game_settings.dart';

class GameRoomCubit extends Cubit<GameRoomState> {
  // String roomId;

  GameRoomCubit() : super(GameRoomInitial());

  void createRoom(
    ConfigurationData data,
  ) {
    print("### cubit create room ###");
    print(
      "### room data - "
      "players: ${data.players}, "
      "rounds: ${data.rounds}, "
      "points: ${data.maxPoints}, "
      "isPrivate: ${data.isPrivate} "
      "###",
    );
  }

  int addPlayerToRoom(String name) {
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
