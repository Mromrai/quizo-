import 'package:flutter/material.dart';
import 'package:quizoo/pages/game_page.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final List<String> difficultytext = ["Easy", "Medium", "Hard"];
  double? _deviceheight, _devicewidth;
  double currdifficultyvalue = 0;

  @override
  Widget build(BuildContext context) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _devicewidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Apptitle(),
                difficultysider(),
                startButton(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Apptitle() {
    return Column(
      children: [
        Text(
          "GR Quiz",
          style: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          "By Om",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        SizedBox(height: 60),
        Text(
          difficultytext[currdifficultyvalue.toInt()],
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget difficultysider() {
    return Slider(
      min: 0,
      max: 2,
      divisions: 3,
      value: currdifficultyvalue,
      onChanged: (_value) {
        setState(() {
          currdifficultyvalue = _value;
          print(currdifficultyvalue);
        });
      },
    );
  }

  Widget startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext) {
              return GamePage(
                difflevl: difficultytext[currdifficultyvalue.toInt()].toLowerCase(),
              
              );
              
            },
          ),
        );
      },
      color: Colors.lightBlueAccent,
      minWidth: _devicewidth! * 0.40,
      height: _deviceheight! * 0.10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(
        "start",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
