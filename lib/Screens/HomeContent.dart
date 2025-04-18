import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  final TextEditingController _controller = TextEditingController();
  String _responseText = '';
  bool _isLoading = false;

  final apiKey = dotenv.env['API_KEY'];

  @override
  /*void initState() {
    // TODO: implement initState
    print((dotenv.env['API_KEY']));
    super.initState();
  }*/

  Future<void> getGeminiResponse(String symptoms) async {
    setState(() {
      _isLoading = true;
      _responseText = '';
    });

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=$apiKey',
    );

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {
              "text":
              "The following symptoms were reported: $symptoms. Provide a JSON response with three fields: 'summary', 'possible_causes', and 'home_remedies'. Do not include any extra disclaimers or explanations outside of this structure."
            }
          ]
        }
      ]
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final resultJson = jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text'];
        final cleanedText = resultJson.replaceAll(RegExp(r'```json\n|\n```'), '');
        final parsedJson = jsonDecode(cleanedText);

        setState(() {
          _responseText = _buildFormattedResponse(parsedJson);
        });
      } else {
        setState(() {
          _responseText = '❌ API Error ${response.statusCode}\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _responseText = '❌ Failed to fetch data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSubmit() {
    final symptoms = _controller.text.trim();
    if (symptoms.isNotEmpty) {
      getGeminiResponse(symptoms);
    } else {
      setState(() {
        _responseText = '⚠️ Please enter your symptoms.';
      });
    }
  }

  String _buildFormattedResponse(Map<String, dynamic> json) {
    return '📝 Summary:\n' +
        json['summary'] +
        '\n\n' +
        '🧠 Possible Causes:\n' +
        json['possible_causes'].join(', ') +
        '\n\n' +
        '🏠 Home Remedies:\n' +
        json['home_remedies'].join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Enter your symptoms',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00BCD4),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _handleSubmit,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Check Symptoms'),
              ),
              SizedBox(height: 24),
              if (_responseText.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFECEFF1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _responseText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
