import '../../../core/database/app_database.dart';
import '../../../core/database/daos/workspace_dao.dart';


class CitationExportService {
  /// Format a single Ayah & Note citation into clean Markdown/Plain Text
  static String formatSingleCitation({
    required String surahNameTranslit,
    required int surahNumber,
    required int ayahNumber,
    required String arabicTextUthmani,
    String? translationText,
    String? noteText,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('📖 Surah $surahNameTranslit ($surahNumber:$ayahNumber)');
    buffer.writeln(arabicTextUthmani);
    if (translationText != null && translationText.isNotEmpty) {
      buffer.writeln('"$translationText"');
    }
    if (noteText != null && noteText.trim().isNotEmpty) {
      buffer.writeln('\n📝 Personal Research Note:');
      buffer.writeln(noteText.trim());
    }
    buffer.writeln('\n— Exported from StudyQuran Workspace');
    return buffer.toString().trim();
  }

  /// Batch format a list of bookmarks & notes for a Collection or Selection, ordered by surah:ayah
  static String formatBatchCitation({
    required String title,
    required List<BookmarkWithAyah> bookmarks,
    List<NoteWithAyah> notes = const [],
  }) {
    // Sort bookmarks by surah:ayah
    final sortedBookmarks = List<BookmarkWithAyah>.from(bookmarks)
      ..sort((a, b) {
        if (a.bookmark.surahNumber != b.bookmark.surahNumber) {
          return a.bookmark.surahNumber.compareTo(b.bookmark.surahNumber);
        }
        return a.bookmark.ayahNumber.compareTo(b.bookmark.ayahNumber);
      });

    final buffer = StringBuffer();
    buffer.writeln('# Research Collection: $title');
    buffer.writeln('Generated on ${DateTime.now().toString().split(' ').first} (${sortedBookmarks.length} entries)\n');
    buffer.writeln('---');

    for (final item in sortedBookmarks) {
      buffer.writeln('\n### ${item.surahNameTranslit} (${item.bookmark.surahNumber}:${item.bookmark.ayahNumber})');
      buffer.writeln(item.arabicTextUthmani);
      if (item.translationText != null) {
        buffer.writeln('"${item.translationText}"');
      }

      // Check if there is an attached note for this ayah
      final matchingNote = notes.firstWhere(
        (n) => n.note.surahNumber == item.bookmark.surahNumber && n.note.startAyah == item.bookmark.ayahNumber,
        orElse: () => NoteWithAyah(
          note: UserNote(
            noteId: '',
            surahNumber: 0,
            startAyah: 0,
            endAyah: 0,
            textContent: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          surahNameTranslit: '',
          surahNameArabic: '',
          arabicTextUthmani: '',
        ),
      );

      if (matchingNote.note.noteId.isNotEmpty && matchingNote.note.textContent.isNotEmpty) {
        buffer.writeln('\n*Note: ${matchingNote.note.textContent}*');
      }
      buffer.writeln('\n---');
    }

    buffer.writeln('\nExported from StudyQuran Research Workspace.');
    return buffer.toString().trim();
  }
}
