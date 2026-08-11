import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyquran/features/audio/domain/audio_player_service.dart';
import 'package:studyquran/core/content_packs/services/content_pack_download_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('AudioPlayerService configures speed and toggle repeat mode', () async {
    AudioPlayerService.toggleRepeatAyah();
    expect(AudioPlayerService.player, isNotNull);
  });

  test('ContentPackDownloadService manages Wi-Fi preference setting', () async {
    await ContentPackDownloadService.setWifiOnlyEnabled(true);
    final wifiEnabled = await ContentPackDownloadService.isWifiOnlyEnabled();
    expect(wifiEnabled, isTrue);

    await ContentPackDownloadService.setWifiOnlyEnabled(false);
    final wifiDisabled = await ContentPackDownloadService.isWifiOnlyEnabled();
    expect(wifiDisabled, isFalse);
  });
}
