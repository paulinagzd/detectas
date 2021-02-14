import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../constants/questions.dart';
import '../screens/nextInstructions.dart';
// import 'package:quiz_app/screens/score/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar
  PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions =
      List.from(m_chat_questions.map((question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
          )));

  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _trueIndex;
  int get trueIndex => this._trueIndex;

  int _selectedAnswer;
  int get selectedAnswer => this._selectedAnswer;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOftrueIndex = 0;
  int get numOftrueIndex => this._numOftrueIndex;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _trueIndex = 0;
    _selectedAnswer = selectedIndex;

    if (_trueIndex == _selectedAnswer) _numOftrueIndex++;

    // It will stop the counter
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(NextStepsPage());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
