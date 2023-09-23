import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  // List<String> xORoList = ['', '', '', '', '', '', '', '', ''];
  List<String> xORoList = List.filled(9, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 20),
          _getScoreBoard(),
          SizedBox(height: 40),
          _getGridView(),
          SizedBox(height: 80),
          _getTurn(),
        ],
      )),
    );
  }

  Widget _getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
            if (xORoList[index].isEmpty) {
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  void _tapped(int index) {
    setState(() {
      xORoList[index] = isTurnO ? 'O' : 'X';
      isTurnO = !isTurnO;
    });
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
                  '0',
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
                child: Text('1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
