import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioByNameController extends ChangeNotifier {
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
    await player.pause();
  }

  stopLocalAudio() async {
    await player.stop();
  }

  resumeLocalAudio() async {
    await player.resume();
  }

  void close() {
    player.dispose();
  }
}
