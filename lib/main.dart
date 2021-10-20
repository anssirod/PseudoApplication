import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pseudo_application/screens/start_screen.dart';
import 'package:pseudo_application/stores/user_store.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<UserStore>(
    UserStore(),
    signalsReady: true,
  );

  runApp(
    const MaterialApp(home: StartScreen()),
  );
}
