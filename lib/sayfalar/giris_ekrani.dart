import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/sayfalar/ogrenci_gecis_ekrani.dart';
import 'package:obs/sayfalar/kayit_ekrani.dart';
import 'package:obs/sayfalar/yonetici_gecis_ekrani.dart';
import 'package:obs/servisler/kullanicilar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ogretim_uyesi_gorevlisi_gecis_ekrani.dart';

class GirisEkrani extends StatefulWidget {

  const GirisEkrani({Key? key}) : super(key: key);

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {

  TextEditingController txt_kimlikNo=TextEditingController();
  TextEditingController txt_sifre=TextEditingController();

  bool sifreGorunurlugu=true;
  bool checkbox1=false;
  var sifreGorunurluguIkon=const Icon(Icons.visibility_rounded);

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refKisiler=FirebaseDatabase.instance.ref().child("kullanicilar_tablo");

  @override
  void initState() {
    tcKimlikSifreKaydet();
    super.initState();
  }

  Future<bool>geriDonusTusu(BuildContext context) async {
    cikisPopUp();
    return true;
  }

  // İlgili tablodan verileri okumak için kullandığımız metot
  Future<void>veriOkuma() async {

    var sayac=0;

    refKisiler.once().then((value) {
      var gelenDegerler=value.snapshot.value as dynamic;

      // Aşağıdaki if yapılarında veri kontrolü yapıyoruz
      if (txt_kimlikNo.text!="" && txt_sifre.text!=""){
        gelenDegerler.forEach((key,nesne){
          var gelenKisi=Kullanicilar.fromJson(key,nesne);
          if (gelenKisi.kisi_tcKimlikNo == txt_kimlikNo.text.toString() &&
              gelenKisi.kisi_sifre == txt_sifre.text.toString()){
            sayac=1;

            Sabitler.ToastKisaSureliMesajDondur("Başarıyla giriş yapıldı."
                "Ana sayfaya yönlendiriliyor...");

            if (gelenKisi.kisi_unvan=="Öğrenci"){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OgrenciGecisEkrani(
                    kisiKimlikNo: gelenKisi.kisi_tcKimlikNo,kisiId: gelenKisi.kisi_id,
                    kisiAdSoyad: gelenKisi.kisi_adSoyad,kisiUnvan: gelenKisi.kisi_unvan,
                    kisiSayac: gelenKisi.kisi_sayac,kisiSifre: gelenKisi.kisi_sifre,
                  kisiProfilResim: gelenKisi.kisi_profilResim,),
                  )
              );
            }else if (gelenKisi.kisi_unvan=="Öğretim Üyesi" || gelenKisi.kisi_unvan=="Öğretim Görevlisi"){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OgretimUyesiGorevlisiGecisEkrani(
                    kisiId: gelenKisi.kisi_id,kisiKimlikNo: gelenKisi.kisi_tcKimlikNo,
                    kisiAdSoyad: gelenKisi.kisi_adSoyad,kisiUnvan: gelenKisi.kisi_unvan,
                    kisiSayac: gelenKisi.kisi_sayac,kisiSifre: gelenKisi.kisi_sifre,
                    kisiProfilResim: gelenKisi.kisi_profilResim,
                  )
                  )
              );
            }if (gelenKisi.kisi_unvan=="Yönetici"){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => YoneticiGecisEkrani(kisiAdSoyad: gelenKisi.kisi_adSoyad,kisiUnvan: gelenKisi.kisi_unvan,
                  kisiKimlikNo: gelenKisi.kisi_tcKimlikNo,kisiId: gelenKisi.kisi_id,kisiProfilResim: gelenKisi.kisi_profilResim,))
              );
            }

          }if (gelenKisi.kisi_tcKimlikNo==txt_kimlikNo.text.toString()){
            if (gelenKisi.kisi_sifre!=txt_sifre.text.toString()){
              sayac=1;
              Sabitler.ToastKisaSureliMesajDondur("Şifre hatalı!");
            }
          }if (gelenKisi.kisi_sifre==txt_sifre.text.toString()){
            if (gelenKisi.kisi_tcKimlikNo!=txt_kimlikNo.text.toString()){
              sayac=1;
              Sabitler.ToastKisaSureliMesajDondur("Tc kimlik no hatalı!");
            }
          }
        });
        if (sayac==0){
          Sabitler.ToastKisaSureliMesajDondur("Girilen bilgilere göre "
              "mevcut bir kullanıcı bulunamadı!");
        }
      }else{
        Sabitler.ToastKisaSureliMesajDondur("Tc kimlik veya şifre alanı boş bırakılamaz!");
      }
    });
  }

  // Uygulamadan çıkış yapacak metot
  void cikisYap() async {
    Sabitler.ToastKisaSureliMesajDondur("Çıkış yapıldı.");
    exit(0);
  }

  // Uygulamadan çıkış yapmak için ilk başta uyarı şeklinde popup
  // geriye döndürecek metot
  void cikisPopUp() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        // Android işletim sistemi yapısında default olarak gelen geri tuşunun
        // ilgili yapılacak işleme göre yeniden kodlanmasını sağlayan yapı
        onWillPop: () => geriDonusTusu(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Center(
                  child: Sabitler.AtaturkUniversitesiLogo(160),
                ),
                const SizedBox(height: 20,),
                Text(
                  "Hoşgeldiniz",
                  style: GoogleFonts.akayaKanadaka(
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 32,),
                Padding(
                  padding: Sabitler.OrtakTextFieldPadding,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Sabitler.OrtakTextFieldContainerColor,
                      borderRadius: Sabitler.OrtakTextFieldContainerBorderRadius,
                      boxShadow: [
                        Sabitler.OrtakTextFieldShadow(),
                      ]
                    ),
                    child: Sabitler.OrtakTextField(txt_kimlikNo, Colors.blue,
                        TextInputType.number, Icons.perm_identity_rounded,
                        Colors.blue, "TC Kimlik Numaranızı Giriniz", "TC Kimlik"),
                  ),
                ),
                const SizedBox(height: 25,),
                Padding(
                  padding: Sabitler.OrtakTextFieldPadding,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Sabitler.OrtakTextFieldContainerColor,
                        borderRadius: Sabitler.OrtakTextFieldContainerBorderRadius,
                        boxShadow: [
                          Sabitler.OrtakTextFieldShadow(),
                        ]
                    ),
                    child: SifreTextField(),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          checkbox(),
                          const Text(
                            "Beni Hatırla",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    girisYapButton(),
                    kayitOlButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // Giriş ekranında ilgili uygulamanın sürüm bilgisini göstermek için kul-
      // landığımız bottom navigation yapısı
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0,left: 170.0,right: 170.0),
          child: Container(
            height: 26,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Sabitler.shadowRenk,
                    blurRadius: 13,
                    offset: const Offset(0, 7)
                ),
              ]
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "V1.0.0",
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(fontSize: 14.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Kullanıcıdan şifre alabileceğimiz textfield yapısı
  Widget SifreTextField(){
    return TextField(
      obscureText: sifreGorunurlugu,
      autocorrect: false,
      enableSuggestions: false,
      textAlign: TextAlign.start,
      controller: txt_sifre,
      cursorColor: Colors.green,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 17,bottom: 17),
        prefixIcon: const Icon(
          Icons.cases_rounded,
          color: Colors.green,
        ),
        suffixIcon: IconButton(
          icon: sifreGorunurluguIkon,
          color: Colors.blue,
          onPressed: (){
            setState(() {
              if (sifreGorunurlugu==false){
                sifreGorunurlugu=true;
                sifreGorunurluguIkon=const Icon(Icons.visibility_rounded);
              }else{
                sifreGorunurlugu=false;
                sifreGorunurluguIkon=const Icon(Icons.visibility_off_rounded);
              }
            });
          },
        ),
        hintText: "Şifrenizi Giriniz",
        hintStyle: TextStyle(
          color: Sabitler.txtRenk,
        ),
        labelText: "Şifre",
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15.0),
        ),
        fillColor: Colors.grey[300],
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  // Kullanıcı bilgilerini sisteme hatırlatabileceğimizi seçebileceğimiz
  // checkbox yapısı
  Widget checkbox(){
    return Checkbox(
      value: checkbox1,
      onChanged: (value) {
        beniHatirla(value!);
        if (value==true){
          Sabitler.ToastKisaSureliMesajDondur("Beni hatırla aktif");
        }else{
          Sabitler.ToastKisaSureliMesajDondur("Beni hatırla pasif");
        }
      },
    );
  }

  // Kullanıcı bilgilerini hatırlatabileceğimiz sharedPreferences tabanlı yapı
  void beniHatirla(bool value) {
    checkbox1=value;
    SharedPreferences.getInstance().then((value1){
      value1.setBool("beni_hatirla", value);
      value1.setString("tcKimlik", txt_kimlikNo.text);
      value1.setString("sifre", txt_sifre.text);
    });
    setState(() {
      checkbox1=value;
    });
  }

  // Kullanıcı bilgilerini hatırlatabileceğimiz sharedPreferences tabanlı yapı
  void tcKimlikSifreKaydet() async {
    try {
      SharedPreferences shp1 = await SharedPreferences.getInstance();
      var tcKimlik = shp1.getString("tcKimlik") ?? "";
      var sifre = shp1.getString("sifre") ?? "";
      var beniHatirla = shp1.getBool("beni_hatirla") ?? false;

      if (beniHatirla) {
        setState(() {
          checkbox1 = true;
        });
        txt_kimlikNo.text = tcKimlik;
        txt_sifre.text = sifre;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget girisYapButton(){
    return SizedBox(
      height: Sabitler.girisEkraniOrtakButtonYukseklik,
      width: Sabitler.girisEkraniOrtakButtonGenislik,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Sabitler.girisEkraniOrtakButtonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: Sabitler.girisEkraniOrtakButtonBorderRadius,
          ),
          elevation: Sabitler.girisEkraniOrtakButtonElevation,
        ),
        child: Sabitler.GirisEkraniOrtakButtonYazi("Giriş Yap"),
        onPressed: (){
          veriOkuma();
        },
      ),
    );
  }

  Widget kayitOlButton(){
    return SizedBox(
      height: Sabitler.girisEkraniOrtakButtonYukseklik,
      width: Sabitler.girisEkraniOrtakButtonGenislik,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Sabitler.girisEkraniOrtakButtonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: Sabitler.girisEkraniOrtakButtonBorderRadius,
          ),
          elevation: Sabitler.girisEkraniOrtakButtonElevation,
        ),
        child: Sabitler.GirisEkraniOrtakButtonYazi("Kayıt Ol"),
        onPressed: (){
          Sabitler.ToastKisaSureliMesajDondur("Kayıt olma sayfasına yönlendiriliyor.");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KayitEkrani()),
          );
        },
      ),
    );
  }
}