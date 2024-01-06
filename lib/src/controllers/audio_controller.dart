import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  final player = AudioPlayer();
  String _path = "sounds/sunny.mp3";

  String get path => _path;

  set path(String value) {
    _path = value;
    notifyListeners();
  }

  playLocal() async {
    await player.play(AssetSource(path));
    await player.setReleaseMode(ReleaseMode.loop);
  }

  pauseLocalAudio() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.pause();
  }

  stopLocalAudio() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
  }

  resumeLocalAudio() async {
    await player.setReleaseMode(ReleaseMode.release);
    await player.resume();
  }

  void close() async {
    await player.dispose();
  }
}
