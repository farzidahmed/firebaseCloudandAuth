class Cricketscore {
  final String matchId;
  final String teamoneName;
  final String teamtwoName;
  final int teamoneScore;
  final int teamotwoScore;
  final bool isMatchRunning;
  final String teamWinner;

  Cricketscore( {required this.teamoneName,
    required this.teamtwoName,
    required this.teamoneScore,
    required this.teamotwoScore,
    required this.isMatchRunning,
    required this.teamWinner,required this.matchId,});

  factory Cricketscore.formJson( String id,Map<String, dynamic>json){
    return Cricketscore(
        matchId: id,
        teamoneName: json['teamoneName'],
        teamtwoName: json[ "teamtwoName"],
        teamoneScore: json[ "teamoneScore"],
        teamotwoScore: json["teamoneScore"],
        isMatchRunning:json["isMatchRunning"],
        teamWinner: json[ "teamWinner"]);
  }

}
