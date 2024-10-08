import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:tugas_quiz_uts/models/Questions.dart';
import 'package:tugas_quiz_uts/screens/score/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data.map<Question>((question) {
    if (question['type'] == 'essay') {
      return EssayQuestion(
        id: question['id'],
        question: question['question'],
      );
    } else {
      return Question(
        id: question['id'],
        question: question['question'],
        options: List<String>.from(question['options']),
        answer: question['answer_index'],
        type: question['type'],
      );
    }
  }).toList();


  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int? _correctAns = 0;
  int? get correctAns => this._correctAns;

  int? _selectedAns = 0;
  int? get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns != null && _correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }
    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to navigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

// Menyimpan jawaban essay
  void saveEssayAnswer(String answer) {
    // Pastikan ada validasi untuk tipe pertanyaan
    if (questions[_questionNumber.value - 1].type == 'essay') {
      // Logika untuk menyimpan jawaban essay
      // Anda mungkin ingin menyimpannya dalam struktur data yang sesuai
      // Misalnya, jika Anda ingin menyimpan di dalam list
    }
  }

  // Mendapatkan jawaban dari semua pertanyaan
  List<dynamic> getAnswers() {
    List<dynamic> answers = [];
    for (var question in questions) {
      if (question.type == 'multiple_choice') {
        answers.add(_selectedAns); // Menyimpan jawaban pilihan ganda
      } else if (question.type == 'essay') {
        // Tambahkan logika untuk menyimpan jawaban essay
      }
    }
    return answers; // Mengembalikan daftar jawaban
  }
}
