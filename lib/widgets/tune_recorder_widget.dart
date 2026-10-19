import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/app_theme.dart';

class TuneRecorderWidget extends StatefulWidget {
  final int hymnNumber;

  const TuneRecorderWidget({Key? key, required this.hymnNumber}) : super(key: key);

  @override
  State<TuneRecorderWidget> createState() => _TuneRecorderWidgetState();
}

class _TuneRecorderWidgetState extends State<TuneRecorderWidget> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _checkExistingRecording();
  }

  Future<void> _checkExistingRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/hymn_${widget.hymnNumber}_tune.m4a');
    if (await file.exists()) {
      setState(() {
        _recordedFilePath = file.path;
      });
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        final path = '${dir.path}/hymn_${widget.hymnNumber}_tune.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        setState(() {
          _isRecording = true;
        });
      }
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path;
      });
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  Future<void> _playRecording() async {
    if (_recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
      setState(() {
        _isPlaying = true;
      });

      _audioPlayer.onPlayerComplete.listen((_) {
        setState(() {
          _isPlaying = false;
        });
      });
    }
  }

  Future<void> _stopPlayback() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.zecBlue.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.zecBlue.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.mic_rounded, color: AppTheme.zecBlue, size: 18),
              SizedBox(width: 6),
              Text(
                'Sunga Chuni / Record Tune',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppTheme.zecBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Record / Stop Record Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRecording ? Colors.redAccent : AppTheme.zecBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(_isRecording ? Icons.stop_rounded : Icons.fiber_manual_record_rounded),
                label: Text(_isRecording ? 'Alesa (Stop)' : 'Jambula (Record)'),
                onPressed: _isRecording ? _stopRecording : _startRecording,
              ),

              const SizedBox(width: 10),

              // Play Recorded Tune Button (If recording exists)
              if (_recordedFilePath != null && !_isRecording)
                IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.zecGold.withOpacity(0.2),
                  ),
                  icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                  color: AppTheme.zecBlue,
                  onPressed: _isPlaying ? _stopPlayback : _playRecording,
                ),
            ],
          ),
        ],
      ),
    );
  }
}