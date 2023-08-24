import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> generateText(String userMessage, String apiKey) async {
  const String apiUrl = 'https://api.openai.com/v1/chat/completions';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  final List<Map<String, dynamic>> messages = [
    {
      'role': 'system',
      'content': 'You are a helpful assistant.',
    },
    {
      'role': 'user',
      'content': userMessage,
    },
  ];

  final Map<String, dynamic> data = {
    'model': 'gpt-3.5-turbo',
    'messages': messages,
  };

  final response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: jsonEncode(data));

  final Map<String, dynamic> result =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return result['choices'][0]['message']['content'];
  } else {
    return result['error']['message'];
    // throw Exception('API request failed: ${response.statusCode}');
  }
}
