import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questionCount,
    this.questions,
  });

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['description'],
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((e) => Questions.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['description'] = description;
    data['time_seconds'] = timeSeconds;
    data['questionCount'] = questionCount;
    if (questions != null) {
      data['questions'] = questions!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  Future<void> uploadToFirestore() async {
    try {
      // Upload the question paper model to Firestore
      await FirebaseFirestore.instance
          .collection('question_papers')
          .doc(id)
          .set(toJson());
      print('Question paper uploaded to Firestore.');

      // Upload each question to Firestore
      if (questions != null) {
        for (var question in questions!) {
          await question.uploadToFirestore(id);
        }
      }
    } catch (e) {
      print('Error uploading question paper to Firestore: $e');
    }
  }
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;

  Questions({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
  });

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers =
            (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = correctAnswer;
    return data;
  }

  Future<void> uploadToFirestore(String paperId) async {
    try {
      // Upload the question to Firestore under the specified question paper ID
      await FirebaseFirestore.instance
          .collection('question_papers')
          .doc(paperId)
          .collection('questions')
          .doc(id)
          .set(toJson());
      print('Question uploaded to Firestore.');
    } catch (e) {
      print('Error uploading question to Firestore: $e');
    }
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['answer'] = answer;
    return data;
  }
}
