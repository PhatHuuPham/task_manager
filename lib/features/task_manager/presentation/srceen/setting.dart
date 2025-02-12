import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/logic/providers/language_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _MySettingState();
}

class _MySettingState extends State<SettingPage> {
  String _selectedLanguage = "en"; // Lưu trữ mã ngôn ngữ

  final Map<String, String> _languages = {
    "en": "English",
    "vi": "Vietnamese",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.language),
            subtitle: Text(_languages[_selectedLanguage] ?? "English"),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: _languages.entries
                  .map((e) => DropdownMenuItem<String>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                    // AppLocalizations.of(context)!.changeLanguage(value);
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLocale(Locale(value));
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
