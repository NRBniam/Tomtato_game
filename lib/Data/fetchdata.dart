/// This is for calling the API

// Import necessary packages for HTTP requests and JSON decoding.
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for fetching quiz data from a web API and adding it to a list.
final quiz = FutureProvider<List>((ref) async {
  // List to store question and solution pairs.
  List<dynamic> questionAnswer = [];

  // Loop to fetch data from the web API (assuming you want to fetch 10 times).
  for (int i = 0; i <= 10; i++) {
    // Create a Dio instance for making HTTP requests.
    final dio = Dio();

    // Make a GET request to the specified API endpoint.
    final response = await dio.get("http://marcconrad.com/uob/tomato/api.php");

    // Decode the JSON response.
    final result = json.decode(response.data);

    // Add the question and solution to the list.
    questionAnswer.add(result['question']);
    questionAnswer.add(result['solution']);
  }

  // Return the list containing question and solution pairs.
  return questionAnswer;
});
