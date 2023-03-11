import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:obs/sayfalar/giris_ekrani.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
with TickerProviderStateMixin {

  // Animasyon kontrolü için kullandığımız nesne
  AnimationController? _controller;
  // Animasyon kontrolü için kullandığımız sayaç
  var sayac=0;

  // Sayfa açıldığı zaman ilk çalışan metot
  @override
  void initState() {
    super.initState();
    _controller=AnimationController(
      // Animasyon süresi
      duration: const Duration(seconds: 3),
      // Görüntü oranının yenilenme hızıyla eşleştirilmesi
      vsync: this,
      reverseDuration: const Duration(seconds: 2),
      // Tekrarlama durumu
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Açılış sayfasında gösterilecek ilgili lottie
      body: Lottie.asset(
        // lottie yolu
        'assets/obs_lottie1.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height*1,
        animate: true,
        repeat: true,
        reverse: true,
        // Lottie'nin yüklenmesi
        onLoaded: (yapi){
          _controller!
            ..duration=yapi.duration
            ..forward(from: 0).whenComplete(() =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const GirisEkrani())));
        },
      ),
    );
  }
}