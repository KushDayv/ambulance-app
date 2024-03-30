import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences _prefs;

  // Example settings variables
  late bool _darkModeEnabled;
  late double _fontSize;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  void _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkModeEnabled = _prefs.getBool('darkModeEnabled') ?? false;
      _fontSize = _prefs.getDouble('fontSize') ?? 16.0;
      _selectedLanguage = _prefs.getString('selectedLanguage') ?? 'English';
    });
  }

  // Save settings to SharedPreferences
  void _saveSettings() {
    _prefs.setBool('darkModeEnabled', _darkModeEnabled);
    _prefs.setDouble('fontSize', _fontSize);
    _prefs.setString('selectedLanguage', _selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Settings'),
      ),
      body: ListView(
        padding:const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title:const Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
              _saveSettings();
            },
          ),
          Slider(
            value: _fontSize,
            min: 12.0,
            max: 24.0,
            divisions: 12,
            onChanged: (value) {
              setState(() {
                _fontSize = value;
              });
              _saveSettings();
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedLanguage,
            items: ['English', 'Spanish', 'French']
                .map((language) => DropdownMenuItem(
              value: language,
              child: Text(language),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
              _saveSettings();
            },
          ),
        ],
      ),
    );
  }
}
