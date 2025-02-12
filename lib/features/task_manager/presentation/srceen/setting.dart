import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/logic/providers/setting_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final Map<String, String> _languages = {
    "en": "English",
    "vi": "Vietnamese",
  };

  final Map<ThemeMode, String> _themes = {
    ThemeMode.light: "Light",
    ThemeMode.dark: "Dark",
    ThemeMode.system: "System",
  };

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: [
          // Cài đặt ngôn ngữ
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.language),
            subtitle: Text(
                _languages[settingProvider.locale.languageCode] ?? "English"),
            trailing: DropdownButton<String>(
              value: settingProvider.locale.languageCode,
              items: _languages.entries
                  .map((e) => DropdownMenuItem<String>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (String? value) {
                if (value != null) {
                  settingProvider.setLocale(Locale(value));
                }
              },
            ),
          ),
          const Divider(),

          // Cài đặt Theme
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            subtitle: Text(_themes[settingProvider.themeMode] ?? 'Light'),
            trailing: DropdownButton<ThemeMode>(
              value: settingProvider.themeMode,
              items: _themes.entries
                  .map((e) => DropdownMenuItem<ThemeMode>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  settingProvider.setThemeMode(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
