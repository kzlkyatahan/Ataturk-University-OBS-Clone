import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/sayfalar/giris_ekrani.dart';
import 'package:obs/sayfalar/uygulama_hakkinda_ekrani.dart';
import 'package:obs/sayfalar/yonetici_ders_listesi_ekrani.dart';
import 'package:obs/sayfalar/yonetici_duyurular_sayfasi.dart';
import 'package:obs/sayfalar/yonetici_kullanici_onaylari_ekrani.dart';
import 'package:obs/sayfalar/yonetici_yemek_listesi_ekrani.dart';

class YoneticiGecisEkrani extends StatefulWidget {

  String kisiAdSoyad;
  String kisiUnvan;
  String kisiKimlikNo;
  String kisiId;
  String kisiProfilResim;

  YoneticiGecisEkrani({Key? key,required this.kisiAdSoyad,
    required this.kisiUnvan,required this.kisiKimlikNo,required this.kisiId,required this.kisiProfilResim}) : super(key: key);

  @override
  State<YoneticiGecisEkrani> createState() => _YoneticiGecisEkraniState();
}

class _YoneticiGecisEkraniState extends State<YoneticiGecisEkrani> {

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refKisiler=FirebaseDatabase.instance.ref().child("kullanicilar_tablo");

  var kisiAdSoyad;
  var kisiUnvan;
  var kisiEmail;

  // İlgili yapıların sayfa türüne göre değişmesini sağlamak için bunları birer
  // değişkenlere attık.
  var appBarTitle="OBS";
  var icon=const Icon(Icons.home_filled);
  var appBarRengi=Colors.blue;

  // Sayfa değişimi için tanımladığımız ilgili sınıftan türeyen nesne
  final pagecontroller=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: Sabitler.gecisEkraniAppBarBorderRadius,
        ),
        elevation: Sabitler.gecisEkraniAppBarElevation,
        actions: [
          Padding(
            padding: Sabitler.gecisEkraniAppBarActionsIconPadding,
            child: icon,
          ),
        ],
        backgroundColor: appBarRengi,
        //appBarTitle
        title: Sabitler.GecisEkraniAppBarBaslik(appBarTitle),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Sabitler.GecisEkraniAppBarLeadingIcon(Icons.menu_rounded),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              tooltip: "Navigasyon Menüsü",
            );
          },
        ),
      ),
      // Kullanıcının ilgili sayfalar arasında geçiş yapmasını sağlayan drawer
      // yapısı
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: Sabitler.gecisEkraniDrawerBorderRadius,
        ),
        width: Sabitler.gecisEkraniDrawerGenislik,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Sabitler.gecisEkraniDrawerElemanlarUstBosluk,
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  boxShadow: [
                    Sabitler.OrtakProfilResimShadow(),
                  ],
                  borderRadius: Sabitler.ortakProfilResimBorderRadius,
                ),
                // İlgili kullanıcının profil fotoğrafının null olup olmadığını
                // kontrol ediyoruz
                child: widget.kisiProfilResim!="" ?
                ClipRRect(
                  borderRadius: Sabitler.ortakProfilResimBorderRadius,
                  child: Image.network(widget.kisiProfilResim,fit: BoxFit.cover,),
                )
                    : ClipRRect(
                  borderRadius: Sabitler.ortakProfilResimBorderRadius,
                  child: Sabitler.OrtakProfilResimNullDegerResim(),
                ),
              ),
              Sabitler.gecisEkraniDrawerProfilResimBilgilerArasiBosluk,
              Sabitler.GecisEkraniDrawerKisiAdSoyad(widget.kisiAdSoyad),
              Sabitler.gecisEkraniDrawerKisiAdSoyadUnvanArasiBosluk,
              Sabitler.GecisEkraniDrawerKisiUnvan(widget.kisiUnvan),
              Sabitler.gecisEkraniDrawerKisiUnvanListTileArasiBosluk,
              Padding(
                padding: Sabitler.gecisEkraniDrawerListTileContainerPadding,
                child: Container(
                  width: double.infinity,
                  height: 410,
                  decoration: BoxDecoration(
                      color: Sabitler.gecisEkraniDrawerListTileContainerRenk,
                      borderRadius: Sabitler.gecisEkraniDrawerListTileContainerBorderRadius,
                      boxShadow: [
                        Sabitler.GecisEkraniDrawerListTileContainerShadow(),
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Sabitler.gecisEkraniDrawerListTileUstBosluk,
                      // Drawer içindeki ilgili sayfalara geçiş yapmamızı sağla-
                      // yan listtile yapısı
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(
                            Icons.play_lesson_rounded,Colors.blue,
                        ),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik(
                            "Ders Görüntüleme Ve Ekleme"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          sayfaDegistirme(0);
                          Navigator.pop(context);
                          // Verileri anlık olarak her yerde aynı anda güncellen-
                          // mesini sağlayan setState yapısı
                          setState(() {
                            appBarTitle="Ders Listesi";
                            appBarRengi=Colors.blue;
                            icon=const Icon(Icons.play_lesson_rounded);
                          });
                        },
                      ),
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(
                            Icons.fact_check_rounded, Colors.teal
                        ),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik(
                            "Kullanıcı Onayları"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          sayfaDegistirme(1);
                          Navigator.pop(context);
                          setState(() {
                            appBarTitle="Kullanıcı Onayları";
                            appBarRengi=Colors.teal;
                            icon=const Icon(Icons.fact_check_rounded);
                          });
                        },
                      ),
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(
                            Icons.fastfood_rounded, Colors.deepOrange
                        ),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik(
                            "Yemek Listesi"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          sayfaDegistirme(2);
                          Navigator.pop(context);
                          setState(() {
                            appBarTitle="Yemek Listesi";
                            appBarRengi=Colors.deepOrange;
                            icon=const Icon(Icons.fastfood_rounded);
                          });
                        },
                      ),
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(
                            Icons.newspaper_rounded, Colors.brown,
                        ),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik(
                            "Duyurular"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          sayfaDegistirme(3);
                          Navigator.pop(context);
                          setState(() {
                            appBarTitle="Duyurular";
                            appBarRengi=Colors.brown;
                            icon=const Icon(Icons.newspaper_rounded);
                          });
                        },
                      ),
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(
                            Icons.info_rounded, Colors.green
                        ),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik(
                            "Uygulama Hakkında"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          sayfaDegistirme(4);
                          Navigator.pop(context);
                          setState(() {
                            appBarTitle="Uygulama Hakkında";
                            appBarRengi=Colors.green;
                            icon=const Icon(Icons.info_rounded);
                          });
                        },
                      ),
                      Sabitler.gecisEkraniDrawerCikisYapListTileUstBosluk,
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(
                            Icons.logout_rounded, Colors.red
                        ),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik(
                            "Çıkış Yap"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          cikisPopUp();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Sabitler.gecisEkraniDrawerListTileAltBosluk,
            ],
          ),
        ),
      ),
      body: WillPopScope(
        // Android işletim sistemi yapısında default olarak gelen geri tuşunun
        // ilgili yapılacak işleme göre yeniden kodlanmasını sağlayan yapı
        onWillPop: () => geriDonusTusu(context),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pagecontroller,
          children: const [
            YoneticiDersListesiEkrani(),
            YoneticiKullaniciOnaylariEkrani(),
            YoneticiYemekListesiEkrani(),
            YoneticiDuyurularEkrani(),
            UygulamaHakkindaEkrani(),
          ],
        ),
      ),
    );
  }

  Future<bool>geriDonusTusu(BuildContext context) async {
    cikisPopUp();
    return true;
  }

  // İlgili sayfalara giderken nasıl bir animasyonla ve
  // zamanla gitmek istediğimizi belirttiğimiz metot
  void sayfaDegistirme(int index){
    pagecontroller.animateToPage(
      index,
      duration: const Duration(microseconds: 500),
      curve: Curves.ease,
    );
  }

  // Ana ekrandan giriş ekranına dönmek için kullanılacak metot
  void cikisYap() async {
    Sabitler.ToastKisaSureliMesajDondur("Çıkış yapıldı.");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
    const GirisEkrani()));
  }

  // Ana ekrandan giriş ekranına geri dönmek için ilk başta uyarı şeklinde
  // popup geriye döndürecek metot
  void cikisPopUp() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: Sabitler.gecisEkraniCikisPopUpAlertDialogBorderRadius,
          ),
          title: const Text(
            "Uyarı",
          ),
          content: const Text(
              "Çıkış yapmak istiyor musunuz?"
          ),
          actions: [
            TextButton(
              child: const Text(
                "Evet",
              ),
              onPressed: (){
                cikisYap();
              },
            ),
            TextButton(
              child: const Text(
                "Hayır",
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}