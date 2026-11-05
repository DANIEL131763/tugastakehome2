import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username = '';
  bool isDarkMode = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username') ?? '';
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      isLoading = false;
    });
  }

  Future<void> saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', name);

    setState(() {
      username = name;
    });
  }

  // Fungsi baru untuk mengubah dan menyimpan tema
  Future<void> toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDarkMode', value);

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
        appBar: AppBar(title: const Text('Settings')),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SettingPage(
          username: username,
          isDarkMode: isDarkMode,
          onSave: saveUsername,
          onThemeChanged: toggleTheme, // Kirim fungsi ke halaman Setting
        ),
      ),
    );
  }
}

class SettingPage extends StatefulWidget {
  final String username;
  final bool isDarkMode;
  final Future<void> Function(String) onSave;
  final Future<void> Function(bool) onThemeChanged; // Komentar dibuka

  // final Future<void> Function() onClear;

  const SettingPage({
    super.key,
    required this.username,
    required this.isDarkMode,
    required this.onSave,
    required this.onThemeChanged, // Komentar dibuka
    // required this.onClear,
  });

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  late TextEditingController controller;

  @override
  void initState(){
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
            widget.username.isEmpty ? 'Selamat Datang' : 'Halo ${widget.username}',
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
          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () async {
              final name = controller.text.trim();

              if(name.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama Tidak Boleh Kosong'))
                );
                return;
              }

              await widget.onSave(name);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nama Berhasil Disimpan'))
              );
            },
            child: const Text('Simpan Nama'),
          ),

          const Divider(height: 32),

          SwitchListTile(
            title: const Text('Mode Gelap'),
            subtitle: const Text('Aktifkan mode gelap ye'),
            value: widget.isDarkMode,
            onChanged: (bool value) async {
              await widget.onThemeChanged(value);
            },
          ),
        ],
      ),
    );
  }
}