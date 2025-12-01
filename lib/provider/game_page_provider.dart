import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import "package:dio/dio.dart";
import 'package:dio/io.dart';
import 'package:html_unescape/html_unescape.dart';

class GamepageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxques = 13;
  final String difflvl;
  List? _questions;
  List? get questions => _questions;
  // final String difficultylvl;
  int _countques = 0;
  int score = 0;
  int _difficultyLevel = 0;
  BuildContext context;
  final List<Map<String, dynamic>> _myQuestions = [
    // my personal questions
    {
      "question": "Will You Marry Mr_Rai?",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question":
          "If a statement is always true in every possible scenario, it is called a tautology.",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question":
          "In classical logic, a contradiction can be true in some cases.",
      "correct_answer": "False",
      "incorrect_answers": ["True"],
    },
    {
      "question":
          "If 'All A are B' is true, and 'All B are C' is true, then 'All A are C' must be true.",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question":
          "The statement 'This statement is false' can be consistently classified as true.",
      "correct_answer": "False",
      "incorrect_answers": ["True"],
    },
    {
      "question": "In logic, a valid argument can still have false premises.",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question":
          "If two events are mutually exclusive, they can occur at the same time.",
      "correct_answer": "False",
      "incorrect_answers": ["True"],
    },
    {
      "question":
          "A biconditional statement (A ↔ B) is true only when both A and B share the same truth value.",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question": "If P implies Q is true, then Q must always be true.",
      "correct_answer": "False",
      "incorrect_answers": ["True"],
    },
    {
      "question":
          "In propositional logic, the negation of 'P OR Q' is 'NOT P OR NOT Q'.",
      "correct_answer": "False",
      "incorrect_answers": ["True"], // correct negation is: NOT P AND NOT Q
    },
    {
      "question":
          "A paradox is a statement that appears self-contradictory but may contain an underlying truth.",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question":
          "If P is false, then the implication 'P implies Q' is always true.",
      "correct_answer": "True",
      "incorrect_answers": ["False"],
    },
    {
      "question":
          "In deductive reasoning, a true conclusion guarantees that the premises were true.",
      "correct_answer": "False",
      "incorrect_answers": ["True"], // conclusion doesn't guarantee premises
    },
    // {
    //   "question": "Mr_Rai fav food is ?",
    //   "correct_answer": "False",
    //   "incorrect_answers": ["True"]
    // }
  ];

  GamepageProvider({required this.context, required this.difflvl}) {
    _dio.options.baseUrl = ("https://opentdb.com/api.php");
    _dio.httpClientAdapter = IOHttpClientAdapter(
      //this httpclient adaptor is used for just allowing ssl certificate for phones who is running on android 7 like my phone because in my phone it's not runninmg
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    _getquestionsAPI();
  }
  Future<void> _getquestionsAPI() async {
    print(difflvl);
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': 12,
        'type': 'boolean',
        'difficulty': difflvl.toLowerCase(),
        'category': 18,
      },
    );
    var _data = jsonDecode(
      response.toString(),
    ); // var _data = response._data it also do the same for json
    _questions = _data["results"];
    _questions!.addAll(_myQuestions);

    notifyListeners();
  }

  // String getCurrentQuestext() {
  //   return _questions![_countques]['question']; // Traversing all the questions using indexed traversal questions[0]['question']based on api key
  // }

  String getCurrentQuestext() {
    var unescape = HtmlUnescape(); // Create the cleaner

    String rawText = _questions![_countques]['question'];

    // Clean the weird symbols and return normal text
    return unescape.convert(rawText);
  }

  void checkAnswers(String _ans) async {
    bool _isCorrect = _questions![_countques]["correct_answer"] == _ans;
    if (_isCorrect) {
      score += 10;
    } else {
      if (score > 0) {
        score -= 5; // Penalty for wrong answer
      }
    }
    ;

    _countques++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _isCorrect ? Colors.green : Colors.red,
          title: Icon(
            _isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);

    if (_countques == _maxques) {
      endgame();
    } else {
      notifyListeners();
    }
  }

  void endgame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            "End_game",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          content: Text(
            "Score: $score/140",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        );
      },
    );
    await Future.delayed(Duration(seconds: 4));
    Navigator.pop(context);
    Navigator.pop(context);
    // Navigator.pop(context);
  }

  void scorevlogic() {
    if (_questions![_countques]["correct_answer"] == "True") {
      score += 10;
    } else {
      // Wrong! Subtract points (optional: prevent negative score)
      if (score > 0) {
        score -= 5; // Penalty for wrong answer
      }
      print("Wrong! Score: $score");
    }
  }
}
