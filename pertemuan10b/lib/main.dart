import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box settingsBox;
  String username = '';
  bool isDarkMode = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box('settings');
    loadData();
  }

  void loadData() {
    setState(() {
      username = settingsBox.get('username', defaultValue: '');
      isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);
      isLoading = false; // Mengubah status loading agar UI ditampilkan
    });
  }

  Future<void> saveUsername(String name) async {
    await settingsBox.put('username', name); // Disimpan ke Hive
    setState(() {
      username = name;
    });
  }

  Future<void> changeTheme(bool value) async {
    await settingsBox.put('isDarkMode', value); // Disimpan ke Hive
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.blue,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SettingsPage(
          username: username,
          isDarkMode: isDarkMode,
          onSave: saveUsername,
          onThemeChanged: changeTheme,
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final String username;
  final bool isDarkMode;
  final Future<void> Function(String) onSave;
  final Future<void> Function(bool) onThemeChanged;

  const SettingsPage({
    super.key,
    required this.username,
    required this.isDarkMode,
    required this.onSave,
    required this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.username);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Icon(Icons.account_circle, size: 100),
          const SizedBox(height: 16),
          Text(
            widget.username.isEmpty
                ? 'Selamat datang!'
                : 'Halo, ${widget.username}!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nama Pengguna',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final name = controller.text.trim();

              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nama tidak boleh kosong'),
                  ),
                );
                return;
              }

              await widget.onSave(name);

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Nama berhasil disimpan'),
                ),
              );
            },
            child: const Text('Simpan Nama'),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
          ),
        ],
      ),
    );
  }
}