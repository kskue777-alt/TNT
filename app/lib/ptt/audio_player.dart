import 'dart:typed_data';

/// Placeholder audio player for the push-to-talk feature.
///
/// This will be wired to a platform specific audio engine in a future
/// iteration. The current stub exists to make the integration points
/// explicit for the networking layer.
class PttAudioPlayer {
  const PttAudioPlayer();

  Future<void> play(Uint8List bytes) async {
    // TODO: Implement playback through a low-latency audio API.
    await Future<void>.delayed(Duration.zero);
  }
}
