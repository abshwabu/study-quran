import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyquran/core/database/providers.dart';

class JumpToDialog extends ConsumerStatefulWidget {
  final int initialSurah;
  final int initialAyah;
  final Function(int surahNumber, int ayahNumber) onJump;

  const JumpToDialog({
    super.key,
    required this.initialSurah,
    required this.initialAyah,
    required this.onJump,
  });

  static void show(
    BuildContext context, {
    required int initialSurah,
    required int initialAyah,
    required Function(int surahNumber, int ayahNumber) onJump,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => JumpToDialog(
        initialSurah: initialSurah,
        initialAyah: initialAyah,
        onJump: onJump,
      ),
    );
  }

  @override
  ConsumerState<JumpToDialog> createState() => _JumpToDialogState();
}

class _JumpToDialogState extends ConsumerState<JumpToDialog> {
  late int _selectedSurah;
  late int _selectedAyah;
  final TextEditingController _ayahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedSurah = widget.initialSurah;
    _selectedAyah = widget.initialAyah;
    _ayahController.text = _selectedAyah.toString();
  }

  @override
  void dispose() {
    _ayahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surahsAsync = ref.watch(surahsProvider);

    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.explore, color: Color(0xFF0F5132)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Jump to Surah & Ayah',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: surahsAsync.when(
        loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
        error: (err, stack) => Text('Error: $err'),
        data: (surahs) {
          final activeSurahMeta = surahs.firstWhere(
            (s) => s.number == _selectedSurah,
            orElse: () => surahs.first,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Select Surah:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              DropdownButtonFormField<int>(
                value: _selectedSurah,
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: surahs.map((s) {
                  return DropdownMenuItem<int>(
                    value: s.number,
                    child: Text(
                      '${s.number}. ${s.nameTranslit} (${s.nameArabic})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedSurah = val;
                      _selectedAyah = 1;
                      _ayahController.text = '1';
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Enter Ayah Number:',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Max: ${activeSurahMeta.ayahCount}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _ayahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: '1 - ${activeSurahMeta.ayahCount}',
                ),
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null && parsed >= 1 && parsed <= activeSurahMeta.ayahCount) {
                    _selectedAyah = parsed;
                  }
                },
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F5132),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            final parsed = int.tryParse(_ayahController.text) ?? 1;
            final validAyah = parsed.clamp(1, 286);
            widget.onJump(_selectedSurah, validAyah);
            Navigator.pop(context);
          },
          child: const Text('Jump'),
        ),
      ],
    );
  }
}
