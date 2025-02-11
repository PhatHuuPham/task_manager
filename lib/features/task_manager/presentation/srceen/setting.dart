import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _MySettingState();
}

class _MySettingState extends State<SettingPage> {
  String _selectedLanguage = "English";
  final List<String> _languages = ["English", "Vietnamese"];

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
              title: const Text("Language"),
              subtitle: const Text("English"),
              trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  items: _languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _selectedLanguage =
                            value; // update the selected language
                      });
                    }
                  }))
        ],
      ),
    );
  }
}
