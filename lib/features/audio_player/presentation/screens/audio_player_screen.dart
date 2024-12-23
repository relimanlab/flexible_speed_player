import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioFilePath;
  double _playbackSpeed = 1.0;
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _audioFilePath = result.files.single.path;
      });
      await _playAudio();
    }
  }

  Future<void> _playAudio() async {
    if (_audioFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_audioFilePath!));
      await _audioPlayer.setPlaybackRate(_playbackSpeed);
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _updatePlaybackSpeed(double speed) async {
    await _audioPlayer.setPlaybackRate(speed);
    setState(() {
      _playbackSpeed = speed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('音楽プレーヤー'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAudioFile,
              child: Text('音楽ファイルを選択'),
            ),
            SizedBox(height: 20),
            Text('再生速度: ${_playbackSpeed.toStringAsFixed(1)}x'),
            Slider(
              value: _playbackSpeed,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              onChanged: _updatePlaybackSpeed,
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _isPlaying ? _pauseAudio : _playAudio,
              iconSize: 48,
            ),
          ],
        ),
      ),
    );
  }
}
