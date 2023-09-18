import 'dart:convert';
import 'package:http/http.dart' as http;
import '/cards.dart';

final String notionDatabaseUrl = 'https://api.notion.com/v1/databases/57c95a9ee92e4f8c89cb909234e3ca80/query';
final String notionToken = 'secret_9h8VXt6j55eUCapkt4Y0IinDKsE1XRMkWBxZ8iErxql';

Future<void> getDatabase(cardTitle, result, question) async {
  final response = await http.post(
    Uri.parse(notionDatabaseUrl),
    headers: {
      'Authorization': 'Bearer $notionToken',
      'Notion-Version': '2022-06-28',
    },
    body: {
      'property': '자신',

    },
  );

  if (response.statusCode == 200) {
    // print(response.body);
    result.clear();
    final data = jsonDecode(response.body);
    // final result = [];
    data['results'].forEach((item){
      // result.add(item);
      // return (item);
      // print(result.indexOf(item));
      final question = item['properties']['question']['rich_text'][0]['text']['content'];
      result.add(item['properties']['question']['rich_text'][0]['text']['content']);
      // print(item['properties']['question']['rich_text'][0]['text']['content']);
    });
    // print(result.);
    return result;

  } else {
    // Handle the error response
    print('Error: ${response.statusCode}');
    print('bye');
    throw Exception('API request failed with status code: ${response.statusCode}');

  }
}
