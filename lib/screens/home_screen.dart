import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  List<String> xORoList = List.filled(9, '');
  int filledList = 0;
  bool gameHasResult = false;
  int playerXScore = 0;
  int playerOScore = 0;
  String buttonTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              onPressed: () {
                _clearGame();
                setState(() {
                  playerOScore = 0;
                  playerXScore = 0;
                });
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
              ))
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 20),
          _getScoreBoard(),
          SizedBox(height: 20),
          _getResultButton(),
          SizedBox(height: 20),
          _getGridView(),
          SizedBox(height: 80),
          _getTurn(),
        ],
      )),
    );
  }

  Widget _getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white, width: 2)),
        onPressed: () {
          _clearGame();
        },
        child: Text(
          'Winner is $buttonTitle, Play Again!',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Player O',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  '$playerOScore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Player X',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  '$playerXScore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getGridView() {
    return GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (xORoList[index].isEmpty && gameHasResult == false) {
              _tapped(index);
            }
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            alignment: Alignment.center,
            child: Text(
              xORoList[index],
              style: TextStyle(
                  fontSize: 42,
                  color: xORoList[index] == 'X' ? Colors.white : Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget _getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  void _tapped(int index) {
    setState(() {
      xORoList[index] = isTurnO ? 'O' : 'X';
      filledList = filledList + 1;
      isTurnO = !isTurnO;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (xORoList[0] == xORoList[1] &&
        xORoList[0] == xORoList[2] &&
        xORoList[0].isNotEmpty) {
      _setResult(xORoList[0]);
    } else if (xORoList[0] == xORoList[3] &&
        xORoList[0] == xORoList[6] &&
        xORoList[0].isNotEmpty) {
      _setResult(xORoList[0]);
    } else if (xORoList[0] == xORoList[4] &&
        xORoList[0] == xORoList[8] &&
        xORoList[0].isNotEmpty) {
      _setResult(xORoList[0]);
    } else if (xORoList[1] == xORoList[4] &&
        xORoList[1] == xORoList[7] &&
        xORoList[1].isNotEmpty) {
      _setResult(xORoList[1]);
    } else if (xORoList[2] == xORoList[5] &&
        xORoList[2] == xORoList[8] &&
        xORoList[2].isNotEmpty) {
      _setResult(xORoList[2]);
    } else if (xORoList[2] == xORoList[4] &&
        xORoList[2] == xORoList[6] &&
        xORoList[2].isNotEmpty) {
      _setResult(xORoList[2]);
    } else if (xORoList[3] == xORoList[4] &&
        xORoList[3] == xORoList[5] &&
        xORoList[3].isNotEmpty) {
      _setResult(xORoList[3]);
    } else if (xORoList[6] == xORoList[7] &&
        xORoList[6] == xORoList[8] &&
        xORoList[6].isNotEmpty) {
      _setResult(xORoList[6]);
    } else if (filledList == 9) {
      _setResult('');
    }
  }

  void _clearGame() {
    setState(() {
      xORoList.fillRange(0, 9, '');
      gameHasResult = false;
    });
    filledList = 0;
  }

  void _setResult(String winner) {
    setState(() {
      buttonTitle = winner;
      gameHasResult = true;
      if (winner == 'X') {
        playerXScore += 1;
      } else if (winner == 'O') {
        playerOScore += 1;
      } else {
        playerOScore += 1;
        playerXScore += 1;
      }
    });
  }
}
