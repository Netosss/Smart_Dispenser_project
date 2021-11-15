import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

Future speak(String string) async {
  FlutterTts _flutterTts = FlutterTts();
  await _flutterTts.setLanguage("en-US");
  await _flutterTts.setSpeechRate(0.4);
  await _flutterTts.speak(string);
}