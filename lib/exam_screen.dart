import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

// Data Models
class ExamData {
  final String message;
  final List<Question> questions;

  ExamData({required this.message, required this.questions});

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      message: json['message'],
      questions:
          (json['questions'] as List).map((q) => Question.fromJson(q)).toList(),
    );
  }
}

class Question {
  final String id;
  final String question;
  final List<Answer> answers;
  final String type;
  final String correct;
  final Subject subject;
  final Exam exam;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
    required this.subject,
    required this.exam,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      question: json['question'],
      answers:
          (json['answers'] as List).map((a) => Answer.fromJson(a)).toList(),
      type: json['type'],
      correct: json['correct'],
      subject: Subject.fromJson(json['subject']),
      exam: Exam.fromJson(json['exam']),
    );
  }
}

class Answer {
  final String answer;
  final String key;

  Answer({required this.answer, required this.key});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answer: json['answer'],
      key: json['key'],
    );
  }
}

class Subject {
  final String id;
  final String name;

  Subject({required this.id, required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Exam {
  final String id;
  final String title;
  final int duration;
  final int numberOfQuestions;

  Exam({
    required this.id,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      numberOfQuestions: json['numberOfQuestions'],
    );
  }
}

// Main Exam Screen
class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late ExamData examData;
  int currentQuestionIndex = 0;
  List<String> selectedAnswers = [];
  late Timer timer;
  Duration timeRemaining = const Duration(minutes: 20, seconds: 19);

  @override
  void initState() {
    super.initState();
    _loadExamData();
    _startTimer();
  }

  void _loadExamData() {
    // Sample JSON data from your API response
    const String jsonData = '''
    {
      "message": "success",
      "questions": [
        {
          "_id": "680806a05554b328912a9dcb",
          "question": "Which method is used to add an element at the beginning of an array in JavaScript?",
          "answers": [
            {"answer": "unshift()", "key": "A1"},
            {"answer": "shift()", "key": "A2"},
            {"answer": "pop()", "key": "A3"},
            {"answer": "push()", "key": "A4"}
          ],
          "type": "single_choice",
          "correct": "A1",
          "subject": {
            "_id": "670039c3728c92b7fdf43506",
            "name": "Javascript"
          },
          "exam": {
            "_id": "6700707030a3c3c1944a9c5d",
            "title": "JavaScript Quiz",
            "duration": 20,
            "numberOfQuestions": 25
          }
        },
        {
          "_id": "680807805554b328912a9e28",
          "question": "What is the result of typeof null in JavaScript?",
          "answers": [
            {"answer": "boolean", "key": "A1"},
            {"answer": "undefined", "key": "A2"},
            {"answer": "object", "key": "A3"},
            {"answer": "null", "key": "A4"}
          ],
          "type": "single_choice",
          "correct": "A3",
          "subject": {
            "_id": "670039c3728c92b7fdf43506",
            "name": "Javascript"
          },
          "exam": {
            "_id": "6700707030a3c3c1944a9c5d",
            "title": "JavaScript Quiz",
            "duration": 20,
            "numberOfQuestions": 25
          }
        },
        {
          "_id": "68096d1b5554b328912b7ad9",
          "question": "Which of the following are valid JavaScript data types? (Multiple choice)",
          "answers": [
            {"answer": "String", "key": "A1"},
            {"answer": "Boolean", "key": "A2"},
            {"answer": "Integer", "key": "A3"},
            {"answer": "Object", "key": "A4"}
          ],
          "type": "multiple_choice",
          "correct": "A1,A2,A4",
          "subject": {
            "_id": "670039c3728c92b7fdf43506",
            "name": "Javascript"
          },
          "exam": {
            "_id": "6700707030a3c3c1944a9c5d",
            "title": "JavaScript Quiz",
            "duration": 20,
            "numberOfQuestions": 25
          }
        }
      ]
    }
    ''';

    final Map<String, dynamic> json = jsonDecode(jsonData);
    examData = ExamData.fromJson(json);
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.inSeconds > 0) {
        setState(() {
          timeRemaining = Duration(seconds: timeRemaining.inSeconds - 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return "$minutes.${seconds.toString().padLeft(2, '0')}";
  }

  Color _getTimerColor() {
    if (timeRemaining.inMinutes < 5) return Colors.red;
    if (timeRemaining.inMinutes < 10) return Colors.orange;
    return Colors.blue;
  }

  void _handleAnswerSelect(String answerKey) {
    setState(() {
      if (examData.questions[currentQuestionIndex].type == "single_choice") {
        selectedAnswers = [answerKey];
      } else {
        if (selectedAnswers.contains(answerKey)) {
          selectedAnswers.remove(answerKey);
        } else {
          selectedAnswers.add(answerKey);
        }
      }
    });
  }

  bool _isAnswerSelected(String answerKey) {
    return selectedAnswers.contains(answerKey);
  }

  void _nextQuestion() {
    if (currentQuestionIndex < examData.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswers.clear();
      });
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswers.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = examData.questions[currentQuestionIndex];
    final progress =
        (currentQuestionIndex + 1) / currentQuestion.exam.numberOfQuestions;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar (Custom)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '9:41',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      // Signal bars
                      Row(
                        children: List.generate(
                            4,
                            (index) => Container(
                                  width: 3,
                                  height: 12,
                                  margin: const EdgeInsets.only(right: 2),
                                  decoration: BoxDecoration(
                                    color: index < 3
                                        ? Colors.black
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                )),
                      ),
                      const SizedBox(width: 4),
                      // WiFi icon
                      const Icon(Icons.wifi, size: 18),
                      const SizedBox(width: 4),
                      // Battery
                      Container(
                        width: 24,
                        height: 12,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    currentQuestion.exam.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 20, color: _getTimerColor()),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(timeRemaining),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _getTimerColor(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Progress Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${currentQuestionIndex + 1} of ${currentQuestion.exam.numberOfQuestions}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          currentQuestion.subject.name,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),

            // Question Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            currentQuestion.question,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: currentQuestion.type == 'single_choice'
                                ? Colors.blue[50]
                                : Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            currentQuestion.type == 'single_choice'
                                ? 'Single'
                                : 'Multiple',
                            style: TextStyle(
                              fontSize: 10,
                              color: currentQuestion.type == 'single_choice'
                                  ? Colors.blue[600]
                                  : Colors.green[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Answer Options
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentQuestion.answers.length,
                        itemBuilder: (context, index) {
                          final answer = currentQuestion.answers[index];
                          final isSelected = _isAnswerSelected(answer.key);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () => _handleAnswerSelect(answer.key),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: currentQuestion.type ==
                                              'multiple_choice' &&
                                          isSelected
                                      ? Colors.blue[50]
                                      : Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.grey[400]!,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.white,
                                      ),
                                      child: isSelected
                                          ? const Icon(Icons.check,
                                              color: Colors.white, size: 14)
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        answer.answer,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      answer.key,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:
                          currentQuestionIndex > 0 ? _previousQuestion : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.blue, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          currentQuestionIndex < examData.questions.length - 1
                              ? _nextQuestion
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main App
class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Text', // iOS font
      ),
      home: const ExamScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(const ExamApp());
}
