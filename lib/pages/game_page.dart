import 'package:flutter/material.dart';
import 'package:quizoo/provider/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWith;
  GamepageProvider? _gamepageProvider;
  final String difflevl;
  GamePage({super.key, required this.difflevl});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWith = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) =>
          GamepageProvider(context: context, difflvl: difflevl),
      child: Builder(
        builder: (context) {
          // Get provider here if needed:

          return build_Ui();
        },
      ),
    );
  }

  Widget build_Ui() {
    return Builder(
      builder: (_context) {
        _gamepageProvider = _context.watch<GamepageProvider>();

        if (_gamepageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceHeight! * 0.05,
                ),
                child: Game_ui(),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
      },
    );
  }

  Widget Game_ui() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questions(),
        SizedBox(height: _deviceHeight! * 0.09),
        Column(
          children: [
            _trueButton(),
            SizedBox(height: _deviceHeight! * 0.01),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questions() {
    return Text(
      _gamepageProvider!.getCurrentQuestext(),
      style: TextStyle(
        fontSize: 25,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _gamepageProvider!.checkAnswers("True");
      },
      color: Colors.green,
      minWidth: _deviceHeight! * 0.80,
      height: _deviceHeight! * 0.10,
      child: Text(
        "True",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _gamepageProvider!.checkAnswers("False");
      },
      color: Colors.red,
      minWidth: _deviceHeight! * 0.80,
      height: _deviceHeight! * 0.10,
      child: Text(
        "False",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
