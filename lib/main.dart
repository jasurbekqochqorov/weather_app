import 'package:flutter/material.dart';

import 'Screen/mainScreen/main_screen.dart';
import 'data/local/storage_repository.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();

  StorageRepository.instance;
  runApp(const MyApp());

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
