import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ai_providers.dart';
import '../../domain/gemini_api_service.dart';
import '../ai_settings_screen.dart';
import '../../../../core/database/providers.dart';


class AiExplainAyahModal extends ConsumerStatefulWidget {
  final String surahNameTranslit;
  final int surahNumber;
  final int ayahNumber;
  final String arabicTextUthmani;
  final String translationText;
  final String? tafsirContext;

  const AiExplainAyahModal({
    super.key,
    required this.surahNameTranslit,
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicTextUthmani,
    required this.translationText,
    this.tafsirContext,
  });

  static void show(
    BuildContext context, {
    required String surahNameTranslit,
    required int surahNumber,
    required int ayahNumber,
    required String arabicTextUthmani,
    required String translationText,
    String? tafsirContext,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AiExplainAyahModal(
        surahNameTranslit: surahNameTranslit,
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        arabicTextUthmani: arabicTextUthmani,
        translationText: translationText,
        tafsirContext: tafsirContext,
      ),
    );
  }

  @override
  ConsumerState<AiExplainAyahModal> createState() => _AiExplainAyahModalState();
}

class _AiExplainAyahModalState extends ConsumerState<AiExplainAyahModal> {
  bool _isLoading = false;
  String? _response;
  String? _error;

  void _generateExplanation(String apiKey) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final res = await GeminiApiService.explainAyah(
        apiKey: apiKey,
        surahNameTranslit: widget.surahNameTranslit,
        surahNumber: widget.surahNumber,
        ayahNumber: widget.ayahNumber,
        arabicTextUthmani: widget.arabicTextUthmani,
        translationText: widget.translationText,
        tafsirContext: widget.tafsirContext,
      );

      final contextLabel = '${widget.surahNameTranslit} (${widget.surahNumber}:${widget.ayahNumber})';
      await ref.read(aiHistoryDaoProvider).saveAiHistory(
            sessionType: 'explain',
            contextLabel: contextLabel,
            promptSent: 'Explain verse $contextLabel with tafsir context',
            responseReceived: res,
          );

      if (mounted) {
        setState(() {
          _response = res;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyAsync = ref.watch(apiKeyProvider);

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'AI Research: Surah ${widget.surahNameTranslit} (${widget.surahNumber}:${widget.ayahNumber})',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // Persistent Mandatory AI Disclaimer Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.amber.shade900),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '⚠️ AI-generated analysis — not a substitute for qualified scholarly tafsir.',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              keyAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err'),
                data: (apiKey) {
                  if (apiKey == null || apiKey.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.vpn_key_outlined, size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          const Text('Gemini API Key Required', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          const Text(
                            'AI analysis requires a free Gemini API key. Set it up in settings to unlock verse explanations.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => const AiSettingsScreen()),
                              );
                            },
                            icon: const Icon(Icons.settings),
                            label: const Text('Open AI Settings'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (_isLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Generating AI verse analysis...', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  }

                  if (_error != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                          child: Text(_error!, style: TextStyle(color: Colors.red.shade900, fontSize: 13)),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => _generateExplanation(apiKey),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    );
                  }

                  if (_response == null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Context to be sent to Gemini:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Ayah ${widget.surahNumber}:${widget.ayahNumber} • "${widget.translationText}"',
                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                          onPressed: () => _generateExplanation(apiKey),
                          icon: const Icon(Icons.auto_awesome),
                          label: const Text('Generate AI Explanation'),
                        ),
                      ],
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Text(
                      _response!,
                      style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
