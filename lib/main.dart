import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager/features/task_manager/logic/providers/language_provider.dart';
import 'firebase_options.dart'; // Import the Firebase options
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Provide the options
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, value, child) {
      return MaterialApp(
        locale: value.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("vi"), // Vietnamese
          Locale("en"), //English
          // Add other locales you want to support
        ],
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      );
    });
  }
}
