class Cricketscore {
  final String matchId;
  final String teamone;
  final String teamtwo;
  final int teamoneScore;
  final int teamotwoScore;
  final bool isMatchRunning;
  final String teamWinner;

  Cricketscore( {required this.teamone,
    required this.teamtwo,
    required this.teamoneScore,
    required this.teamotwoScore,
    required this.isMatchRunning,
    required this.teamWinner,required this.matchId,});

  factory Cricketscore.formJson( String id,Map<String, dynamic>json){
    return Cricketscore(
        matchId: id,
        teamone: json['teamone'],
        teamtwo: json[ "teamtwo"],
        teamoneScore: json[ "teamonescore"],
        teamotwoScore: json["teamonescore"],
        isMatchRunning:json["ismatchrunning"],
        teamWinner: json[ "winnerteam"]);
  }

}
