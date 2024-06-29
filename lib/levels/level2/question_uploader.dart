import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'question_paper_model.dart';

class QuestionUploader {
  static Future<void> uploadLoanQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/loan_questions.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    QuestionPaperModel questionPaper = QuestionPaperModel.fromJson(jsonMap);
    await questionPaper.uploadToFirestore();
  }

  static Future<void> uploadStockQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/stock_questions.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    QuestionPaperModel questionPaper = QuestionPaperModel.fromJson(jsonMap);
    await questionPaper.uploadToFirestore();
  }

  static Future<void> uploadBankingQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/banking_questions.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    QuestionPaperModel questionPaper = QuestionPaperModel.fromJson(jsonMap);
    await questionPaper.uploadToFirestore();
  }

  static Future<void> uploadRealEstateQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/real_estate_questions.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    QuestionPaperModel questionPaper = QuestionPaperModel.fromJson(jsonMap);
    await questionPaper.uploadToFirestore();
  }
}
