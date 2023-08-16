import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> generateText(String prompt, String apiKey) async {
  const String apiUrl =
      'https://api.openai.com/v1/engines/text-davinci-003/completions';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  final Map<String, dynamic> data = {
    'prompt': prompt,
    'max_tokens': 50,
  };

  final response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: jsonEncode(data));
  if (kDebugMode) {
    print(response.body);
  }
  if (response.statusCode == 200) {
    final Map<String, dynamic> result = jsonDecode(response.body);
    return result['choices'][0]['text'];
  } else {
    throw Exception('API request failed: ${response.statusCode}');
  }
}
