import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Membuka database
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'mahasiswa.db');

  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE mahasiswa (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nim TEXT,
          nama TEXT,
          prodi TEXT
        )
      ''');
    },
  );

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final Database db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(db: db),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Database db;

  const MyHomePage({super.key, required this.db});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List> mahasiswa = [];

  final nimController = TextEditingController();
  final namaController = TextEditingController();
  final prodiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // READ
  Future<void> loadData() async {
    final data = await widget.db.query('mahasiswa');
    setState(() {
      mahasiswa = data;
    });
  }

  // CREATE & UPDATE (Dialog Form)
  Future<void> simpanData(int? id) async {
    nimController.clear();
    namaController.clear();
    prodiController.clear();

    if (id != null) {
      final data = mahasiswa.firstWhere((item) => item['id'] == id);
      nimController.text = data['nim'];
      namaController.text = data['nama'];
      prodiController.text = data['prodi'];
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(id == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nimController, // Diperbaiki dari Controller ke controller
              decoration: const InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: namaController, // Diperbaiki dari Controller ke controller
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: prodiController, // Diperbaiki dari Controller ke controller
              decoration: const InputDecoration(labelText: 'Prodi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final nim = nimController.text.trim();
              final nama = namaController.text.trim();
              final prodi = prodiController.text.trim();

              if (nim.isEmpty || nama.isEmpty || prodi.isEmpty) return; // Ditambah titik koma

              final data = {
                'nim': nim,
                'nama': nama,
                'prodi': prodi,
              };

              if (id == null) {
                // Tambah data baru
                await widget.db.insert('mahasiswa', data);
              } else {
                // Update data berdasarkan id
                await widget.db.update(
                  'mahasiswa',
                  data,
                  where: 'id = ?',
                  whereArgs: [id],
                );
              }

              // Refresh data dan tutup dialog
              await loadData();
              Navigator.pop(dialogContext);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Database - SQLite'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: mahasiswa.isEmpty
          ? const Center(child: Text('Belum ada data mahasiswa'))
          : ListView.builder(
        itemCount: mahasiswa.length,
        itemBuilder: (BuildContext context, int index) {
          final data = mahasiswa[index];

          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(data['nama']),
            subtitle: Text(
              '${data['nim']} - ${data['prodi']}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () => simpanData(data['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => simpanData(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}