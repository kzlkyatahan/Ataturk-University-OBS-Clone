import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/sayfalar/giris_ekrani.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {

  // Kaydedeceğimiz kullanıcının profil fotoğrafını almak için kullanaca-
  // ğımız ilgili değişken yapıları
  String imageUrl="";
  String profilResim="";

  TextEditingController txt_kimlikNo = TextEditingController();
  TextEditingController txt_adsoyad = TextEditingController();
  TextEditingController txt_telno = TextEditingController();
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_unvan = TextEditingController();

  // İlgili veri tabanında tablo oluşturmak için kullandığımız bir yapı
  var refGeciciKisiler=FirebaseDatabase.instance.ref().child("gecici_kullanicilar_tablo");
  var refKisiler=FirebaseDatabase.instance.ref().child("kullanicilar_tablo");

  Future<bool>geriDonusTusu(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const GirisEkrani()));
    return true;
  }

  // Yeni kaydedilecek kullanıcının sistem kaydının yönetici tarafından onaylanmadan
  // önce geçici tabloya kaydedilmesini sağlayan yapı
  Future<void> geciciKullaniciKayit() async {
    var geciciKullanicilar=HashMap<String,dynamic>();
    var sayac=0;
    geciciKullanicilar["geciciKisi_id"]="";
    geciciKullanicilar["geciciKisi_tcKimlikNo"]=txt_kimlikNo.text.toString();
    geciciKullanicilar["geciciKisi_adSoyad"]=txt_adsoyad.text.toString();
    geciciKullanicilar["geciciKisi_telNo"]=txt_telno.text.toString();
    geciciKullanicilar["geciciKisi_email"]=txt_email.text.toString();
    geciciKullanicilar["geciciKisi_unvan"]=txt_unvan.text.toString();
    geciciKullanicilar["geciciKisi_sifre"]=txt_kimlikNo.text.toString();
    geciciKullanicilar["geciciKisi_sayac"]=sayac.toString();

    if (profilResim==""){
      geciciKullanicilar["geciciKisi_profilResim"]="";
    }else{
      geciciKullanicilar["geciciKisi_profilResim"]=profilResim;
    }

    refGeciciKisiler.push().set(geciciKullanicilar);
  }

  // Eğer yeni kaydedilecek kullanıcın ünvanı yönetici ise kaydının otomatik
  // olarak ana tabloya kaydedilmesini sağlayan yapı
  Future<void> kullaniciKayit() async{

    var kullanicilar=HashMap<String,dynamic>();
    var sayac=1;
    kullanicilar["kisi_id"]="";
    kullanicilar["kisi_tcKimlikNo"]=txt_kimlikNo.text;
    kullanicilar["kisi_adSoyad"]=txt_adsoyad.text;
    kullanicilar["kisi_telNo"]=txt_telno.text;
    kullanicilar["kisi_email"]=txt_email.text;
    kullanicilar["kisi_unvan"]=txt_unvan.text;
    kullanicilar["kisi_sifre"]=txt_kimlikNo.text;
    kullanicilar["kisi_sayac"]=sayac.toString();

    if (profilResim==""){
      kullanicilar["kisi_profilResim"]="";
    }else{
      kullanicilar["kisi_profilResim"]=profilResim;
    }

    refKisiler.push().set(kullanicilar);
  }

  // Kaydını yapacak ilgili kullanıcının profil fotoğrafını seçip sisteme kaydet-
  // mesini sağlayacak yapı
  Future<void> kullaniciResimYukle() async{

    ImagePicker imagePicker=ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    debugPrint('${file?.path}');

    if (file==null) return;

    String uniqueFileName=txt_kimlikNo.text.toString();

    Reference referenceRoot=FirebaseStorage.instance.ref();
    Reference referenceDirImages=referenceRoot.child('images');

    Reference referenceImageToUpload=referenceDirImages.child(uniqueFileName);

    try{
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl=await referenceImageToUpload.getDownloadURL();

      setState(() {
        profilResim=imageUrl;
      });

    }catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          "Kayıt Ol",
          style: GoogleFonts.akayaKanadaka(
            textStyle: const TextStyle(fontSize: 22),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GirisEkrani())
            );
          },
        ),
      ),
      body: WillPopScope(
        // Android işletim sistemi yapısında default olarak gelen geri tuşunun
        // ilgili yapılacak işleme göre yeniden kodlanmasını sağlayan yapı
        onWillPop: () => geriDonusTusu(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 17,),
                Center(
                  child: Sabitler.AtaturkUniversitesiLogo(140),
                ),
                const SizedBox(height: 30,),
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
                        TextInputType.number, Icons.perm_identity_rounded, Colors.blue,
                        "TC Kimlik Numaranızı Giriniz", "TC Kimlik"),
                  ),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
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
                    child: Sabitler.OrtakTextField(txt_adsoyad, Colors.blue,
                        TextInputType.name, Icons.perm_identity_rounded, Colors.blue,
                        "Ad Soyad Giriniz", "Ad Soyad"),
                  ),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
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
                    child: Sabitler.OrtakTextField(txt_telno, Colors.blue,
                        TextInputType.phone, Icons.phone_android_rounded, Colors.blue,
                        "Telefon Numarası Giriniz", "Telefon Numarası"),
                  ),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
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
                    child: Sabitler.OrtakTextField(txt_email, Colors.blue,
                        TextInputType.emailAddress,Icons.mail_rounded, Colors.blue,
                        "Email Adresi Giriniz", "Email"),
                  ),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
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
                    child: Sabitler.OrtakTextField(txt_unvan, Colors.blue,
                        TextInputType.text, Icons.supervisor_account_rounded, Colors.blue,
                        "Ünvan Giriniz", "Ünvan"),
                  ),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          boxShadow: [
                            Sabitler.OrtakProfilResimShadow(),
                          ],
                          borderRadius: Sabitler.ortakProfilResimBorderRadius,
                        ),

                        // Galeriden alınan ilgili profil resmini tutan değiş-
                        // kenin null olup olmadığını kontrol ediyoruz
                        child: profilResim!="" ?
                        ClipRRect(
                          borderRadius: Sabitler.ortakProfilResimBorderRadius,
                          child: Image.network(profilResim,fit: BoxFit.cover,),
                        )
                            : ClipRRect(
                          borderRadius: Sabitler.ortakProfilResimBorderRadius,
                          child: Sabitler.OrtakProfilResimNullDegerResim(),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      SizedBox(
                        height: 42,
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Sabitler.shadowRenk,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: (){
                            kullaniciResimYukle();
                          },
                          child: const Text(
                            "Fotoğraf Yükle",
                            style: TextStyle(
                              fontSize: 14.5
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
                Center(
                  child: kayitOlButton(),
                ),
                Sabitler.girisEkraniTextFieldBosluk,
              ],
            ),
          ),
        ),
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

          if (txt_kimlikNo.text.toString()!="" && txt_adsoyad.text.toString()!="" && txt_telno.text.toString()!="" &&
              txt_email.text.toString()!="" && txt_unvan.text.toString()!=""){
            if (txt_unvan.text.toString()!="Yönetici"){
              geciciKullaniciKayit();
              Sabitler.ToastUzunSureliMesajDondur("Geçici kaydınız yapıldı."
                  "Kaydınızın tamamlanması için Yönetici"
                  " onayı bekleniyor...");
            }
            if (txt_unvan.text.toString()=="Yönetici"){
              kullaniciKayit();
              Sabitler.ToastKisaSureliMesajDondur("Yönetici kaydı yapıldı.");
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const GirisEkrani())
            );
          }else{
            Sabitler.ToastUzunSureliMesajDondur("Kayıt olunamadı."
                "Lütfen bilgilerinizi eksiksiz biçimde doldurunuz!");
          }
        },
      ),
    );
  }
}