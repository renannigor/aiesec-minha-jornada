import 'package:aiesec_minha_jornada/features/auth/presentation/pages/auth_controller_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MinhaJornada());
}

class MinhaJornada extends StatelessWidget {
  const MinhaJornada({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIESEC System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF037EF3)),
        useMaterial3: true,
      ),
      home: const AuthControllerPage(),
    );
  }
}
