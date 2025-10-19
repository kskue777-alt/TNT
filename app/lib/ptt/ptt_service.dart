import 'dart:async';
import 'dart:typed_data';

/// Provides the core push-to-talk interactions for the application.
///
/// This service currently exposes a simplified API for beginning and
/// ending microphone capture along with placeholder methods for
/// sending and receiving audio frames. The transport layer will be
/// implemented with WebRTC in a future iteration.
class PttService {
  PttService._();

  static final PttService instance = PttService._();

  bool _isCapturing = false;
  final StreamController<Uint8List> _incomingAudioController =
      StreamController.broadcast();

  bool get isCapturing => _isCapturing;

  Stream<Uint8List> get incomingAudioStream =>
      _incomingAudioController.stream;

  /// Starts microphone capture.
  ///
  /// The concrete audio acquisition will be added once native platform
  /// integration is complete.
  Future<void> startCapture() async {
    if (_isCapturing) {
      return;
    }

    // TODO: Wire this up to the platform channel that enables the
    // microphone stream. The current implementation only toggles the
    // state flag to unblock the UI flow.
    _isCapturing = true;
  }

  /// Stops the microphone capture and finalises the push-to-talk
  /// message payload.
  Future<void> stopCapture() async {
    if (!_isCapturing) {
      return;
    }

    // TODO: Close the microphone stream and dispatch the buffered
    // audio to the networking layer.
    _isCapturing = false;
  }

  /// Sends raw audio to the other participant.
  ///
  /// WebRTC integration will replace this stub in a future revision.
  Future<void> sendAudioChunk(Uint8List bytes) async {
    // TODO: Implement WebRTC data channel forwarding.
    await Future<void>.delayed(Duration.zero);
  }

  /// Handles incoming audio data from the remote participant.
  Future<void> receiveAudio(Uint8List bytes) async {
    // TODO: Replace with a direct hook into the audio player once the
    // networking layer is wired up.
    _incomingAudioController.add(bytes);
  }

  Future<void> dispose() async {
    await _incomingAudioController.close();
  }
}
