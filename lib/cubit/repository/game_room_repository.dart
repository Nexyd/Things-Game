class GameRoomRepository {
  Future<String> createRoom(
    String roomJson, [
    bool isPrivate = false,
  ]) async {
    return "";
  }

  Future<List<String>> getRooms() async {
    return [""];
  }

  Future<String> updatePlayers(String id, List<String> playerList) async {
    return "";
  }

  Future<String> updateBoard(String id, String boardJson) async {
    return "";
  }

  Future<String> deleteRoom(String id) async {
    return "";
  }
}
