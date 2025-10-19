import 'package:flutter/material.dart';

import 'ptt_service.dart';

/// A push-to-talk button widget that starts capturing audio while it is
/// pressed and stops once released.
class PttButton extends StatefulWidget {
  const PttButton({super.key, PttService? service}) : _service = service;

  final PttService? _service;

  @override
  State<PttButton> createState() => _PttButtonState();
}

class _PttButtonState extends State<PttButton> {
  late final PttService _service = widget._service ?? PttService.instance;
  bool _isPressed = false;

  Future<void> _handleStart() async {
    if (_isPressed) {
      return;
    }

    setState(() {
      _isPressed = true;
    });

    await _service.startCapture();
  }

  Future<void> _handleStop() async {
    if (!_isPressed) {
      return;
    }

    setState(() {
      _isPressed = false;
    });

    await _service.stopCapture();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _handleStart(),
      onLongPressEnd: (_) => _handleStop(),
      onLongPressCancel: _handleStop,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.redAccent : Colors.blueAccent,
          shape: BoxShape.circle,
          boxShadow: [
            if (_isPressed)
              const BoxShadow(
                blurRadius: 12,
                color: Colors.black26,
                offset: Offset(0, 6),
              ),
          ],
        ),
        child: Icon(
          _isPressed ? Icons.mic : Icons.mic_none,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}
