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
    "Indonesia merdeka tahun berapa ?",
    "options": ['1942', '1945', '1943', '1944'],
    "answer_index": 1,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 2,
    "question": "Siapakah presiden indonesia ke 4?",
    "options": ['Soekarno', 'Habibie', 'Gusdur', 'Soeharto'],
    "answer_index": 2,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 3,
    "question": "Indonesia di jajah oleh jepang selama ...",
    "options": ['1 Tahun', '2 Tahun', '3 Tahun', '3,5 Tahun'],
    "answer_index": 3,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 4,
    "question": "Ada berapa negara yang sudah pernah menjajah indonesia?",
    "options": ['Tiga', 'Empat', 'Enam', 'Lima'],
    "answer_index": 2,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 5,
    "question": "Apakah benar negara Thailand tidak pernah dijajah?",
    "options": ['Benar', 'Salah'],
    "answer_index": 0,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 6,
    "question": "Negara terbesar di dunia adalah",
    "options": ['China', 'Amerika', 'Jepang', 'Rusia'],
    "answer_index": 3,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 7,
    "question": "Berapa banyak medali emas yang diraih indonesia selama olimpiade?",
    "options": ['5', '4', '10', '8'],
    "answer_index": 2,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 8,
    "question": "Apakah benar Indonesia memiliki lebih dari 17.000 pulau?",
    "options": ['Benar', 'Salah'],
    "answer_index": 0,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 9,
    "question": "Apakah benar negara ASEAN terdiri dari 8 negara?",
    "options": ['Benar', 'Salah'],
    "answer_index": 1,
    "type": "multiple_choice", // Jenis soal
  },
  {
    "id": 10,
    "question": "Jelaskan arti dari Bhineka Tunggal Ika.",
    "options": [], // Kosongkan untuk soal essay
    "answer_index": null, // Tidak ada jawaban index untuk essay
    "type": "essay", // Jenis soal essay
  },
];

List<Question> _question = sample_data.map<Question>((question) {
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