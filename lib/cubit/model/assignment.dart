class Assignment {
  String playerName;
  Map<String, String> playerAssignment;

  Assignment({
    required this.playerName,
    required this.playerAssignment,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      playerName: json["playerName"],
      playerAssignment: json["playerAssignment"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "playerName": playerName,
      "playerAssignment": playerAssignment
    };
  }
}
