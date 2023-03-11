import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/sayfalar/ogrenci_ders_listesi_ekrani.dart';
import 'package:obs/sayfalar/duyurular_ekrani.dart';
import 'package:obs/sayfalar/giris_ekrani.dart';
import 'package:obs/sayfalar/ogrenci_notlar_ekrani.dart';
import 'package:obs/sayfalar/uygulama_hakkinda_ekrani.dart';
import 'package:obs/sayfalar/yemek_listesi_ekrani.dart';

class OgrenciGecisEkrani extends StatefulWidget {

  String kisiKimlikNo;
  String kisiId;
  String kisiAdSoyad;
  String kisiUnvan;
  String kisiSayac;
  String kisiSifre;
  String kisiProfilResim;

  OgrenciGecisEkrani({Key? key,
    required this.kisiKimlikNo,required this.kisiId,
    required this.kisiAdSoyad,required this.kisiUnvan,
    required this.kisiSayac,required this.kisiSifre,required this.kisiProfilResim})
      : super(key: key);

  @override
  State<OgrenciGecisEkrani> createState() => _OgrenciGecisEkraniState();
}

class _OgrenciGecisEkraniState extends State<OgrenciGecisEkrani> {

  TextEditingController txt_sifre_yenileme=TextEditingController();

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

  // Kullanıcının bir defaya mahsus şifresinin yenilenmesini sağlayan metot
  Future<void> kullaniciSifreYenile(String kisi_id,String kisi_sifre ) async {
    var kullanicilar=HashMap<String,dynamic>();
    var sayac=1;
    kullanicilar["kisi_sifre"]=kisi_sifre;
    kullanicilar["kisi_sayac"]=sayac.toString();

    refKisiler.child(kisi_id).update(kullanicilar);
  }

  // Şifre yenilemeyi bir popup yapısında gösteren bu durumu kontrol eden metot
  void sifreYenilemeKontrol(BuildContext context) {
    debugPrint("Şifre Yenileme Metodunun içindesin.");
    var sayacKontrol=0;
    if (widget.kisiSayac==sayacKontrol.toString()){
      setState(() {
        widget.kisiSayac="1";
      });
      debugPrint("Sayaç kontrol geçildi.");
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: Sabitler.sifreYenilemeAlertDialogBorderRadius,
            ),
            scrollable: true,
            title: Sabitler.SifreYenilemeAlertDialogBaslik("Şifre Yenileme"),
            content: Padding(
              padding: Sabitler.sifreYenilemeAlertDialogFormPadding,
              child: Form(
                child: Column(
                  children: [
                    Sabitler.SifreYenilemeTextFormField(txt_sifre_yenileme),
                  ],
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Padding(
                padding: Sabitler.sifreYenilemeButtonPadding,
                child: SizedBox(
                  width: Sabitler.sifreYenilemeButtonGenislik,
                  height: Sabitler.sifreYenilemeButtonYukseklik,
                  child: ElevatedButton(
                    onPressed: (){
                      kullaniciSifreYenile(widget.kisiId, txt_sifre_yenileme.text);
                      Navigator.pop(context);
                      Sabitler.ToastKisaSureliMesajDondur("Mevcut şifreniz yenilendi.");
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: Sabitler.sifreYenilemeButtonBorderRadius,
                      ),
                      shadowColor: Sabitler.shadowRenk,
                      elevation: Sabitler.sifreYenilemeButtonElevation,
                    ),
                    child: Sabitler.SifreYenilemeButtonYazi("Şifre Yenile"),
                  ),
                ),
              ),
            ],
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Şifre yenileme kontrolünü sağlayan sayaç yapısı
    var sayacKontrol=0;
    if (widget.kisiSayac==sayacKontrol.toString()){
      Future.delayed(const Duration(seconds: 1),() => sifreYenilemeKontrol(context));
    }
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
                  height: Sabitler.gecisEkraniDrawerListTileContainerYukseklik,
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
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(Icons.play_lesson_rounded,
                            Colors.blue),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik("Ders Listesi"),
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
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(Icons.grade_rounded,
                            Colors.teal),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik("Notlar"),
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.gecisEkraniDrawerListTileBorderRadius,
                        ),
                        onTap: (){
                          sayfaDegistirme(1);
                          Navigator.pop(context);
                          setState(() {
                            appBarTitle="Notlar";
                            appBarRengi=Colors.teal;
                            icon=const Icon(Icons.grade_rounded);
                          });
                        },
                      ),
                      ListTile(
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(Icons.fastfood_rounded,
                            Colors.deepOrange),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik("Yemek Listesi"),
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
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(Icons.newspaper_rounded,
                            Colors.brown),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik("Duyurular"),
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
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(Icons.info_rounded,
                            Colors.green),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik("Uygulama Hakkında"),
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
                        leading: Sabitler.GecisEkraniDrawerListTileIcon(Icons.logout_rounded,
                            Colors.red),
                        title: Sabitler.GecisEkraniDrawerListTileBaslik("Çıkış Yap"),
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
          children: [
            OgrenciDersListesiEkrani(kisiKimlikNo: widget.kisiKimlikNo,
            kisiId: widget.kisiId,kisiAdSoyad: widget.kisiAdSoyad,kisiUnvan: widget.kisiUnvan,
            kisiSayac: widget.kisiSayac,kisiSifre: widget.kisiSifre,),
            OgrenciNotlarEkrani(kisiAdSoyad: widget.kisiAdSoyad,kisiKimlikNo: widget.kisiKimlikNo,kisiId: widget.kisiId,),
            const YemekListesiEkrani(),
            const DuyurularEkrani(),
            const UygulamaHakkindaEkrani(),
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GirisEkrani()));
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