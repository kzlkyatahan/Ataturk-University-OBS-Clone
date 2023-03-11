import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:obs/firebase_options.dart';
import 'package:obs/sayfalar/splash_screen.dart';

void main() async {
  // Firebase veri tabanını entegre edebilmek için kullanmamız gereken yapı
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Görev yöneticisinde gözükecek uygulama adı
      title: 'Öğrenci Bilgi Sistemi',
      // Uygulama içerisinde debug yazısının görünmemesi için gereken kod
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Uygulamanın birincil renk paleti
        primarySwatch: Colors.blue,
      ),
      // Uygulama açılış animasyonunu içinde barındıran sayfa
      home: const SplashScreen(),
    );
  }
}