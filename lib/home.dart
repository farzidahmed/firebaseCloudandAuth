import 'dart:ui_web';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing_app/cricketscror.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Cricketscore> _cricketScorelist=[];
   bool _inprogress = false;

  Future<void> _getscricketscore()async{
    _inprogress=true;
  _cricketScorelist.clear();
  final QuerySnapshot snapshot = await _firebaseFirestore.collection('cricket').get();
  for(DocumentSnapshot doc in snapshot.docs){
      _cricketScorelist.add(Cricketscore.formJson( doc.id,doc.data()as Map<String,dynamic>));
  }
    _inprogress=false;
    setState(() {
  });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _getscricketscore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live score"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Visibility(
              visible: _inprogress==false,
              replacement: const CircularProgressIndicator(),
              child: ListView.builder(
                  itemCount: _cricketScorelist.length,
                  itemBuilder: (context,index){
                    Cricketscore cricketscore= _cricketScorelist[index];
                    return ListTile(
                      leading: Badge(
                      backgroundColor:_indicatior(cricketscore.isMatchRunning),
                      ),
                      title: Text(cricketscore.matchId),
                      subtitle: Text("Team 1 :${cricketscore.teamoneName} Team 2 : ${cricketscore.teamtwoName}"),
                      trailing: Text("${cricketscore.teamoneScore}/${cricketscore.teamotwoScore}"),
                    );
              }),
            ),
          )
        ],
      ),
    );
  }
  Color _indicatior(bool isMatchrunning){
    return isMatchrunning? Colors.green: Colors.grey;
  }


}
