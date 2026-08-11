import 'package:dio/dio.dart';

class GeminiApiException implements Exception {
  final String message;
  final int? statusCode;

  GeminiApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class GeminiApiService {
  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
  ));

  static const String _systemPrompt = '''
You are an AI research assistant specializing in Quranic textual analysis and comparative tafsir. 
- Work strictly from the text, verses, translations, and tafsir excerpts provided in the prompt context.
- Do NOT issue religious rulings (fatwa) or present your answers as absolute religious authority.
- Note clearly when a question would be better directed to a qualified Islamic scholar.
- Maintain an academic, respectful, and objective tone.
''';

  static String _buildUrl(String apiKey) {
    return 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';
  }

  /// Test Connection to validate API key
  static Future<bool> testConnection(String apiKey) async {
    try {
      final response = await _dio.post(
        _buildUrl(apiKey),
        data: {
          "contents": [
            {
              "parts": [
                {"text": "Ping test. Respond with OK."}
              ]
            }
          ]
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        final code = e.response!.statusCode;
        if (code == 400 || code == 403) {
          throw GeminiApiException('Invalid Gemini API Key (HTTP $code)', code);
        } else if (code == 429) {
          throw GeminiApiException('API Quota Exceeded (HTTP 429)', code);
        }
      }
      throw GeminiApiException('Network error or invalid connection: ${e.message}');
    } catch (e) {
      throw GeminiApiException('Unexpected connection error: $e');
    }
  }

  /// Feature 1: Explain Ayah with Tafsir Context
  static Future<String> explainAyah({
    required String apiKey,
    required String surahNameTranslit,
    required int surahNumber,
    required int ayahNumber,
    required String arabicTextUthmani,
    required String translationText,
    String? tafsirContext,
  }) async {
    final prompt = '''
$_systemPrompt

Context Verse:
Surah $surahNameTranslit ($surahNumber:$ayahNumber)
Arabic: $arabicTextUthmani
Translation: "$translationText"
${tafsirContext != null ? "\nSelected Classical Tafsir Context:\n$tafsirContext" : ""}

Task: Provide a clear, plain-language academic research explanation of this verse based on the provided text and tafsir context. Highlighting key thematic insights and vocabulary.
''';

    return _generateContent(apiKey, prompt);
  }

  /// Feature 2: Compare Tafsir Views
  static Future<String> compareTafsirs({
    required String apiKey,
    required String ayahReference,
    required List<({String tafsirName, String text})> tafsirs,
  }) async {
    final buffer = StringBuffer();
    for (final item in tafsirs) {
      buffer.writeln('\n--- ${item.tafsirName} ---');
      buffer.writeln(item.text);
    }

    final prompt = '''
$_systemPrompt

Context Verse: $ayahReference
Classical Tafsir Excerpts:
${buffer.toString()}

Task: Compare these classical tafsir excerpts. Summarize:
1. Primary points of agreement between the commentators.
2. Distinctive analytical angles or points of divergence.
3. Concise summary for research notes.
''';

    return _generateContent(apiKey, prompt);
  }

  /// Feature 3: Research Summary from Workspace Collection
  static Future<String> summarizeWorkspace({
    required String apiKey,
    required String collectionName,
    required List<String> entries,
  }) async {
    final prompt = '''
$_systemPrompt

Research Collection: "$collectionName"
Verses & Research Notes:
${entries.join('\n\n---\n\n')}

Task: Draft a structured synthesis and thematic research overview of these verses and notes. Organize into key sub-themes suitable as a starting point for an essay or khutbah notes.
''';

    return _generateContent(apiKey, prompt);
  }

  static Future<String> _generateContent(String apiKey, String prompt) async {
    try {
      final response = await _dio.post(
        _buildUrl(apiKey),
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final candidates = response.data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'].toString();
          }
        }
      }
      throw GeminiApiException('Empty response received from Gemini API');
    } on DioException catch (e) {
      if (e.response != null) {
        final code = e.response!.statusCode;
        if (code == 400 || code == 403) {
          throw GeminiApiException('Invalid Gemini API Key. Please check settings.', code);
        } else if (code == 429) {
          throw GeminiApiException('API Quota Exceeded. Please wait a moment.', code);
        }
      }
      throw GeminiApiException('Network error: Unable to connect to Gemini API. Please check your internet connection.');
    } catch (e) {
      throw GeminiApiException('AI Generation error: $e');
    }
  }
}
