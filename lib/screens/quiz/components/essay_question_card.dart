import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_quiz_uts/controllers/question_controller.dart';
import 'package:tugas_quiz_uts/models/Questions.dart';
import 'package:tugas_quiz_uts/screens/score/score_screen.dart'; // Pastikan Anda mengimpor ScoreScreen

class EssayQuestionCard extends StatelessWidget {
  final EssayQuestion question;

  const EssayQuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.find();
    TextEditingController answerController = TextEditingController();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: answerController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Tulis jawaban Anda di sini...",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20), // Tambahkan jarak antara TextField dan tombol
          ElevatedButton(
            onPressed: () {
              // Memanggil metode saveEssayAnswer dengan jawaban yang diberikan
              _controller.saveEssayAnswer(answerController.text);

              // Navigasi ke ScoreScreen
              Future.delayed(Duration(seconds: 1), () {
                Get.to(ScoreScreen()); // Navigasi ke ScoreScreen
              });
            },
            child: Text("Submit"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
