import 'package:just_audio/just_audio.dart';

class AudioPlaybackState {
  final bool isPlaying;
  final int currentSurah;
  final int currentAyah;
  final String reciterId;
  final double playbackSpeed;
  final bool isRepeatAyah;

  AudioPlaybackState({
    required this.isPlaying,
    required this.currentSurah,
    required this.currentAyah,
    required this.reciterId,
    required this.playbackSpeed,
    required this.isRepeatAyah,
  });
}

class AudioPlayerService {
  static final AudioPlayer _player = AudioPlayer();
  static int _currentSurah = 1;
  static int _currentAyah = 1;
  static String _reciterId = 'audio.alafasy';
  static double _speed = 1.0;
  static bool _repeatAyah = false;

  static AudioPlayer get player => _player;

  static String _formatAyahAudioUrl(int surah, int ayah) {
    final surahStr = surah.toString().padLeft(3, '0');
    final ayahStr = ayah.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/Alafasy_128kbps/$surahStr$ayahStr.mp3';
  }

  static Future<void> playAyah({
    required int surahNumber,
    required int ayahNumber,
    Function(int surah, int ayah)? onAyahChanged,
  }) async {
    _currentSurah = surahNumber;
    _currentAyah = ayahNumber;

    final url = _formatAyahAudioUrl(surahNumber, ayahNumber);

    try {
      await _player.setUrl(url);
      await _player.setSpeed(_speed);
      await _player.play();

      if (onAyahChanged != null) {
        onAyahChanged(_currentSurah, _currentAyah);
      }

      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          if (_repeatAyah) {
            playAyah(surahNumber: _currentSurah, ayahNumber: _currentAyah, onAyahChanged: onAyahChanged);
          } else if (_currentAyah < 7) {
            // Auto advance to next verse
            playAyah(surahNumber: _currentSurah, ayahNumber: _currentAyah + 1, onAyahChanged: onAyahChanged);
          }
        }
      });
    } catch (e) {
      // Graceful fallback for offline mode
    }
  }

  static Future<void> pause() async {
    await _player.pause();
  }

  static Future<void> stop() async {
    await _player.stop();
  }

  static Future<void> setSpeed(double speed) async {
    _speed = speed;
    await _player.setSpeed(speed);
  }

  static void toggleRepeatAyah() {
    _repeatAyah = !_repeatAyah;
  }
}
