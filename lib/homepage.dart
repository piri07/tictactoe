import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/dialouge.dart';
import 'package:tictactoe/game_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Gamebutton> buttonsList;
  var player1;
  var player2;
  var activeplayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList =doInit();
  }
  List<Gamebutton> doInit(){
    player1 =new List();
    player2 = new List();
    activeplayer = 1;
      var gamebuttons=<Gamebutton>[
        new Gamebutton(id:1),
        new Gamebutton(id:2),
        new Gamebutton(id:3),
        new Gamebutton(id:4),
        new Gamebutton(id:5),
        new Gamebutton(id:6),
        new Gamebutton(id:7),
        new Gamebutton(id:8),
        new Gamebutton(id:9),
      ];
      return gamebuttons;
  }
  void playGame(Gamebutton gb){
    setState(() {
      if(activeplayer==1){
        gb.text = "X";
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      }else{
        gb.text = "0";
        gb.bg = Colors.black;
        activeplayer =1;
        player2.add(gb.id);
      }
      gb.enabled=false;
      int winner= checkWinner();
      if(winner==-1){
        if(buttonsList.every((p) => p.text!='')){
          showDialog(
              context: context,
            builder: (_)=> new CustomDialog("Game Tied", "Click Reset to start new game", resetGame)
          );
        }else{
          activeplayer==2?autoplay():null;
        }
      }
    });
}
void autoplay(){
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i+1);
    for(var cellid in list){
      if(!(player1.contains(cellid) || player2.contains(cellid))){
        emptyCells.add(cellid);
      }
    }
    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellId = emptyCells[randIndex];
    int i =buttonsList.indexWhere((p) => p.id==cellId);
    playGame(buttonsList[i]);
}

int checkWinner(){
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)){
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)){
      winner = 2;
    }
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)){
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)){
      winner = 2;
    }
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)){
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)){
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)){
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)){
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)){
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)){
      winner = 2;
    }

    if(winner!=-1){
      if(winner==1){
        showDialog(
            context:context,
          builder: (_)=> CustomDialog("Player 1 has Won","Click Reset to play Again",resetGame)
        );

      }else{
        showDialog(
            context:context,
            builder: (_)=> CustomDialog("Player 2 has Won","Click Reset to play Again",resetGame)
        );
      }
    }
    return winner;

}

void resetGame(){
    if(Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Tic Tac Toe"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0,
              ),
              itemCount: buttonsList.length,
              itemBuilder:(context,i)=> new SizedBox(
                width: 100.0,
                height: 100.0,
                child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: buttonsList[i].enabled ? ()=>playGame(buttonsList[i]):null,
                  child: new Text(buttonsList[i].text,style: new TextStyle(color: Colors.white,fontSize: 20.0),
                  ),
                  color: buttonsList[i].bg,
                  disabledColor: buttonsList[i].bg,
                ),
              ),
            ),
          ),
          new RaisedButton(
              onPressed: resetGame,
            child: new Text("Reset",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            color: Colors.red,
            padding: const EdgeInsets.all(20.0),
          )
        ],
      )
    );
  }
}
