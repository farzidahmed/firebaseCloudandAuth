import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing_app/cricketscror.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Cricketscore> _cricketScorelist = [];

  void _extractdata(QuerySnapshot<Map<String, dynamic>>? snapshot) {
    _cricketScorelist.clear();
    for (DocumentSnapshot doc in snapshot?.docs ?? []) {
      _cricketScorelist.add(
          Cricketscore.formJson(doc.id, doc.data() as Map<String, dynamic>));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live score"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("cricket").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              _extractdata(snapshot.data);
              return ListView.builder(
                  itemCount: _cricketScorelist.length,
                  itemBuilder: (context, index) {
                    Cricketscore cricketscore = _cricketScorelist[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            _indicatior(cricketscore.isMatchRunning),
                      ),
                      title: Text(
                        cricketscore.matchId,
                        style: TextStyle(fontSize: 24),
                      ),
                      subtitle: Text(
                          "Team 1 :${cricketscore.teamone} \nTeam 2 : ${cricketscore.teamtwo}\n WinnerTeam:${cricketscore.teamWinner == '' ? 'Pending' : cricketscore.teamWinner}"),
                      trailing: Text(
                          "${cricketscore.teamoneScore}/${cricketscore.teamotwoScore}"),
                    );
                  });
            }
            return SizedBox();
          }),
    );
  }

  Color _indicatior(bool isMatchrunning) {
    return isMatchrunning ? Colors.green : Colors.grey;
  }
}
