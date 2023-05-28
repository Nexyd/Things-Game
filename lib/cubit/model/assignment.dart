class Assignment {
  String playerName;
  List<String> playerAssignment;

  Assignment({
    required this.playerName,
    required this.playerAssignment,
  });

  factory Assignment.fromJson(
    Map<String, dynamic> json,
  ) {
    return Assignment(
      playerName: json["playerName"],
      playerAssignment: List<String>.from(
        json["playerAssignment"].map((x) => x),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "playerName": playerName,
      "playerAssignment": List<dynamic>.from(
        playerAssignment.map((x) => x),
      ),
    };
  }
}
