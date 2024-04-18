import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  // Pastikan untuk menginisialisasi kamera sebelum menjalankan aplikasi
  WidgetsFlutterBinding.ensureInitialized();
  // Dapatkan daftar kamera yang tersedia
  final cameras = await availableCameras();
  // Pilih kamera yang akan digunakan (biasanya kamera belakang)
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Buat instance CameraController
    _controller = CameraController(
      widget.camera,
      // Tentukan resolusi gambar
      ResolutionPreset.medium,
    );
    // Inisialisasi controller dan mulai preview kamera
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Pastikan untuk melepaskan kamera ketika tidak digunakan lagi
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Example'),
      ),
      // Tunggu hingga kamera terinisialisasi sebelum menampilkan preview
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika kamera terinisialisasi, tampilkan preview
            return CameraPreview(_controller);
          } else {
            // Jika belum, tampilkan indikator loading
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
