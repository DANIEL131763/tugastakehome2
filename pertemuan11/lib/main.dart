import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 5 MobProg',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212), // warna gelap spotify
      ),
      home: const HalamanCari(),
    );
  }
}

// Halaman buat cari lagu
class HalamanCari extends StatefulWidget {
  const HalamanCari({super.key});

  @override
  State<HalamanCari> createState() => _HalamanCariState();
}

class _HalamanCariState extends State<HalamanCari> {
  final inputController = TextEditingController();
  List dataLagu = [];
  bool lagiLoading = false;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  // fungsi nembak api itunes
  Future<void> cariLagu() async {
    final keyword = inputController.text.trim();
    if (keyword.isEmpty) return;

    setState(() {
      lagiLoading = true;
    });

    try {
      final url = Uri.https(
        'itunes.apple.com',
        '/search',
        {
          'term': keyword,
          'entity': 'song',
          'limit': '15', // nampilin 15 lagu aja
        },
      );

      final respon = await http.get(url);

      if (respon.statusCode == 200) {
        final hasilJson = jsonDecode(respon.body);
        setState(() {
          dataLagu = hasilJson['results'];
        });
      } else {
        print('Gagal ngambil data: ${respon.statusCode}');
      }
    } catch (e) {
      print('Error nih: $e');
    } finally {
      if (mounted) setState(() => lagiLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Lagu'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // tombol ke profil
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HalamanProfil()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // form input pencarian
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: 'Ketik judul atau artis...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: cariLagu,
                ),
              ),
              onSubmitted: (_) => cariLagu(),
            ),
            const SizedBox(height: 12),

            // nampilin hasil pencarian pake listview
            Expanded(
              child: lagiLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.greenAccent))
                  : ListView.builder(
                itemCount: dataLagu.length,
                itemBuilder: (context, index) {
                  final lagu = dataLagu[index];
                  final linkPreview = lagu['previewUrl'];

                  return ListTile(
                    leading: lagu['artworkUrl100'] != null
                        ? Image.network(lagu['artworkUrl100'])
                        : const Icon(Icons.music_note),
                    title: Text(
                      lagu['trackName'] ?? 'Judul ga ada',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(lagu['artistName'] ?? 'Artis ga ada'),
                    onTap: linkPreview != null
                        ? () {
                      // Lempar data ke halaman player
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanPlayer(
                            listLagu: dataLagu,
                            indexAwal: index,
                          ),
                        ),
                      );
                    }
                        : null, // kalo ga ada link preview, ga bisa di-klik
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Profil Mahasiswa
class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF1DB954), // ijo spotify
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              'Daniel Witarsa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Sistem Informasi',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
            ),
            Text(
              'Universitas Tarumanagara',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman buat muter musiknya
class HalamanPlayer extends StatefulWidget {
  final List listLagu;
  final int indexAwal;

  const HalamanPlayer({
    super.key,
    required this.listLagu,
    required this.indexAwal,
  });

  @override
  State<HalamanPlayer> createState() => _HalamanPlayerState();
}

class _HalamanPlayerState extends State<HalamanPlayer> {
  final AudioPlayer playerMusik = AudioPlayer();
  bool lagiMain = false;
  late int indexSekarang;

  @override
  void initState() {
    super.initState();
    indexSekarang = widget.indexAwal;
    putarLaguSekarang();

    // ngecek kalo lagunya udah beres diputer (30 detik)
    playerMusik.onPlayerComplete.listen((event) {
      if (mounted) {
        // kalo masih ada lagu selanjutnya
        if (indexSekarang < widget.listLagu.length - 1) {
          laguSelanjutnya();
        } else {
          setState(() {
            lagiMain = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    playerMusik.stop();
    playerMusik.dispose();
    super.dispose();
  }

  // fungsi play lagu
  Future<void> putarLaguSekarang() async {
    final lagu = widget.listLagu[indexSekarang];
    final url = lagu['previewUrl'];

    if (url != null) {
      await playerMusik.stop();
      await playerMusik.play(UrlSource(url));
      setState(() {
        lagiMain = true;
      });
    }
  }

  // fungsi tombol play/pause
  Future<void> pauseAtauPlay() async {
    if (lagiMain) {
      await playerMusik.pause();
      setState(() => lagiMain = false);
    } else {
      await playerMusik.resume();
      setState(() => lagiMain = true);
    }
  }

  // fungsi next lagu
  void laguSelanjutnya() {
    if (indexSekarang < widget.listLagu.length - 1) {
      setState(() {
        indexSekarang++;
      });
      putarLaguSekarang();
    }
  }

  // fungsi prev lagu
  void laguSebelumnya() {
    if (indexSekarang > 0) {
      setState(() {
        indexSekarang--;
      });
      putarLaguSekarang();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lagu = widget.listLagu[indexSekarang];
    String gambarCover = lagu['artworkUrl100'] ?? '';

    // biar gambarnya ga buram, resolusinya digedein dikit
    gambarCover = gambarCover.replaceAll('100x100', '400x400');

    bool bisaPrev = indexSekarang > 0;
    bool bisaNext = indexSekarang < widget.listLagu.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lagi Diputer',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar cover lagunya
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(gambarCover),
                    fit: BoxFit.cover,
                  ),
                ),
                child: gambarCover.isEmpty
                    ? const Icon(Icons.music_note, size: 100)
                    : null,
              ),
              const SizedBox(height: 40),

              // Judulnya
              Text(
                lagu['trackName'] ?? 'Judul ga ada',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Nama Artisnya
              Text(
                lagu['artistName'] ?? 'Artis ga ada',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 40),

              // Tombol Prev, Play/Pause, Next
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 40,
                    color: bisaPrev ? Colors.white : Colors.grey.shade800,
                    icon: const Icon(Icons.skip_previous),
                    onPressed: bisaPrev ? laguSebelumnya : null,
                  ),
                  GestureDetector(
                    onTap: pauseAtauPlay,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1DB954), // ijo spotify
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        lagiMain ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 40,
                    color: bisaNext ? Colors.white : Colors.grey.shade800,
                    icon: const Icon(Icons.skip_next),
                    onPressed: bisaNext ? laguSelanjutnya : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}