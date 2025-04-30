import 'package:flutter/material.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ← yeni

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Image Downloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _urlCtrl = TextEditingController();
  bool _busy = false;
  String? _status;
  String? _previewUrl;

  Future<void> _download() async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) {
      setState(() => _status = '⚠️  Lütfen bir resim URL\'i girin.');
      return;
    }
    setState(() {
      _busy = true;
      _status = null;
    });
    try {
      await WebImageDownloader.downloadImageFromWeb(url);
      setState(() => _status = '✅  İndirme tamamlandı!');
    } catch (e) {
      setState(() => _status = '❌  Hata: $e');
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    // URL yazıldıkça önizleme güncellensin
    _urlCtrl.addListener(() {
      final text = _urlCtrl.text.trim();
      if (text != _previewUrl) {
        setState(() => _previewUrl = text.isEmpty ? null : text);
      }
    });
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: sw < 600 ? sw * .9 : 500),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Resim İndir',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _urlCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Resim URL\'i',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.link),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // —— ÖNİZLEME ALANI ——
                      if (_previewUrl != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: _previewUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (ctx, url) => Container(
                              color: Colors.grey.shade200,
                              height: 200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (ctx, url, err) => Container(
                              color: Colors.grey.shade200,
                              height: 200,
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 48),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _busy ? null : _download,
                          icon: const Icon(Icons.download),
                          label: _busy
                              ? SpinKitFadingCube(
                                  size: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                )
                              : const Text('İndir'),
                        ),
                      ),
                      if (_status != null) ...[
                        const SizedBox(height: 20),
                        Text(
                          _status!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _status!.startsWith('✅')
                                ? Colors.green
                                : _status!.startsWith('❌')
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
