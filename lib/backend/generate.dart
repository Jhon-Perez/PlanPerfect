import 'dart:convert';
import 'dart:io';
import 'package:haghocks/backend/openai_prompts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

Future getCompletion(String prompt, String description, bool calendar) async {
  var apiKey = Platform
      .environment['sk-3lsziSmQigs7oPhLIQGjCT3BlbkFJKPc64RPlBS7IsRrkEcEk7g'];
  var instructions = exerciseInstructions;
  var date = DateTime.now();
  var completion = !calendar
      ? await _getCompletionFromOpenAI(
          apiKey!, instructions, prompt, description)
      : await _getCalendarCompletion(
          apiKey!, instructions, prompt, description, date);
  print(completion['choices'][0]['message']['content']);
  return json.decode(completion['choices'][0]['message']['content']);
}

Future<Map<String, dynamic>> _getCompletionFromOpenAI(String apiKey,
    String instructions, String prompt, String description) async {
  var url = 'https://api.openai.com/v1/chat/completions';
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  var body = jsonEncode({
    "model": "gpt-3.5-turbo",
    "messages": [
      {"role": "system", "content": instructions},
      {
        "role": "user",
        "content": """
{
  "prompt": "$prompt",
  "instructions: "$instructions",
}
"""
      }
    ]
  });
  var response = await http.post(Uri.parse(url), headers: headers, body: body);
  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> _getCalendarCompletion(
    String apiKey,
    String instructions,
    String prompt,
    String description,
    DateTime date) async {
  var url = 'https://api.openai.com/v1/chat/completions';
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  var body = jsonEncode({
    "model": "gpt-3.5-turbo",
    "messages": [
      {"role": "system", "content": instructions},
      {
        "role": "user",
        "content": """
{
  "prompt": "$prompt",
  "instructions: "$instructions",
}
"""
      }
    ]
  });
  var response = await http.post(Uri.parse(url), headers: headers, body: body);
  return jsonDecode(response.body);
}


/*

{
    "date": "2024-04-13",
    "name": "Brisk Walking",
    "description": "Brisk walking involves walking at a pace that elevates your heart rate and increases your breathing rate. It's a low-impact exercise that can be done almost anywhere.",
    "intensity": "Low to Moderate",
    "duration": "30-45 minutes per session",
    "equipment": "Comfortable walking shoes",
    "how_to": "Start with a warm-up, then walk at a pace that allows you to maintain a conversation but still feel slightly breathless. Gradually increase your pace as you progress.",
    "cooldown": "End each session with a 5-10 minute cooldown of slower walking."
},

*/