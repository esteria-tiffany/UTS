class Question {
  final int id; // non-nullable
  final String question;
  final int? answer; // non-nullable
  final List<String> options;
  final String? type; // multiple_choice atau essay

  // Menggunakan required untuk memastikan parameter diisi
  Question({
    required this.id, // required
    required this.question, // required
    required this.answer, // required
    required this.options, // required
    this.type, // multiple_choice atau essay
  });
}

class EssayQuestion extends Question {
  EssayQuestion({
    required int id,
    required String question,
  }) : super(
    id: id,
    question: question,
    answer: null, // tidak ada jawaban untuk pertanyaan essay
    options: [], // tidak ada opsi untuk pertanyaan essay
    type: 'essay', // menetapkan tipe sebagai 'essay'
  );
}

const List<Map<String, dynamic>> sample_data = [
  {
    "id": 1,
    "question":
    "Flutter is an open-source UI software development kit created by ______",
    "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    "answer_index": 1,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 2,
    "question": "When google release Flutter.",
    "options": ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
    "answer_index": 2,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 3,
    "question": "A memory location that holds a single letter or number.",
    "options": ['Double', 'Int', 'Char', 'Word'],
    "answer_index": 2,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 4,
    "question": "What command do you use to output data to the screen?",
    "options": ['Cin', 'Count>>', 'Cout', 'Output>>'],
    "answer_index": 2,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 5,
    "question": "Explain the concept of state management in Flutter.",
    "options": [], // Kosongkan untuk soal essay
    "answer_index": null, // Tidak ada jawaban index untuk essay
    "type": "essay", // Jenis soal essay
  },
];

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
}) .toList();