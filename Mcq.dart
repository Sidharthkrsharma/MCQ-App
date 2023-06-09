import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class Question {
  String question;
  List<String> options;
  String answer;
  Question({
    required this.question,
    required this.options,
    required this.answer,
  });
  bool isCorrect(String chosenAnswer) {
    if (chosenAnswer == this.answer)
      return true;
    else
      return false;
  }
}
class Quiz {
  List<Question> questions = [
    Question(
      question: "What is 2+2?",
      options: ["4", "5", "6", "7"],
      answer: "A",
    ),
    Question(
      question: "What is 7*5?",
      options: ["34", "35", "36", "37"],
      answer: "B",
    ),
    Question(
      question: "What is 20% of 40?",
      options: ["5", "6", "7", "8"],
      answer: "D",
    ),
  ];
  void registerAttempt(String optionId) {
    if (attemptedQuestions < questions.length) {
      if (questions[index].isCorrect(optionId)) {
        currentScore++;
      }
      attemptedQuestions++;
    }
    if (index < questions.length - 1) {
      index++;
    }
  }
  int currentScore = 0;
  int attemptedQuestions = 0;
  int index = 0;
}
class _MyAppState extends State<MyApp> {
  Quiz quiz = Quiz();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Score: ${quiz.currentScore}/${quiz.attemptedQuestions}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      child: Text(
                        quiz.questions[quiz.index].question,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    optionBox(
                        quiz: quiz,
                        optionId: "A",
                        parentRebuild: () {
                          setState(() {});
                        },
                        option: quiz.questions[quiz.index].options[0]),
                    SizedBox(
                      width: 10,
                    ),
                    optionBox(
                        quiz: quiz,
                        optionId: "B",
                        parentRebuild: () {
                          setState(() {});
                        },
                        option: quiz.questions[quiz.index].options[1]),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    optionBox(
                        quiz: quiz,
                        optionId: "C",
                        parentRebuild: () {
                          setState(() {});
                        },
                        option: quiz.questions[quiz.index].options[2]),
                    SizedBox(
                      width: 10,
                    ),
                    optionBox(
                        quiz: quiz,
                        optionId: "D",
                        parentRebuild: () {
                          setState(() {});
                        },
                        option: quiz.questions[quiz.index].options[3]),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class optionBox extends StatelessWidget {
  const optionBox({
    Key? key,
    required this.quiz,
    required this.optionId,
    required this.parentRebuild,
    required this.option,
  }) : super(key: key);
  final void Function() parentRebuild;
  final Quiz quiz;
  final String optionId, option;
  @override
  Widget build(BuildContext context) {
    var question = quiz.questions[quiz.index];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          quiz.registerAttempt(optionId);
          parentRebuild();
        },
        child: Container(
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${optionId}. ${option}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}

