import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/kullaniciNotlari.dart';

class OgretimUyesiGorevlisiNotlarEkrani extends StatefulWidget {
  const OgretimUyesiGorevlisiNotlarEkrani({Key? key}) : super(key: key);

  @override
  State<OgretimUyesiGorevlisiNotlarEkrani> createState() => _OgretimUyesiGorevlisiNotlarEkraniState();
}

class _OgretimUyesiGorevlisiNotlarEkraniState extends State<OgretimUyesiGorevlisiNotlarEkrani> {

  TextEditingController txt_kullaniciNotKimlikNo=TextEditingController();
  TextEditingController txt_kullaniciNotAdSoyad=TextEditingController();
  TextEditingController txt_kullaniciNotDers=TextEditingController();
  TextEditingController txt_kullaniciVizeNot=TextEditingController();
  TextEditingController txt_kullaniciFinalNot=TextEditingController();

  TextEditingController txt_kullaniciNotGuncelleKimlikNo=TextEditingController();
  TextEditingController txt_kullaniciNotGuncelleAdSoyad=TextEditingController();
  TextEditingController txt_kullaniciNotGuncelleDers=TextEditingController();
  TextEditingController txt_kullaniciNotGuncelleVizeNot=TextEditingController();
  TextEditingController txt_kullaniciNotGuncelleFinalNot=TextEditingController();



  // İlgili veri tabanında tablo oluşturmak için kullandığımız bir yapı
  var refNotlar=FirebaseDatabase.instance.ref().child("notlar_tablo");

  // Kullanıcı notlarını tabloya kaydedilmesini sağlayacak metot
  Future<void> kullaniciNotKayit() async{
    var kullaniciNotlari=HashMap<String,dynamic>();
    kullaniciNotlari["kullaniciNot_Id"]="";
    kullaniciNotlari["kullaniciNot_Kimlik"]=txt_kullaniciNotKimlikNo.text.toString();
    kullaniciNotlari["kullaniciNot_AdSoyad"]=txt_kullaniciNotAdSoyad.text.toString();
    kullaniciNotlari["kullaniciNot_Ders"]=txt_kullaniciNotDers.text.toString();
    kullaniciNotlari["kullaniciNot_VizeNot"]=txt_kullaniciVizeNot.text.toString();
    kullaniciNotlari["kullaniciNot_FinalNot"]=txt_kullaniciFinalNot.text.toString();

    var kullaniciVizeNot=int.parse(txt_kullaniciVizeNot.text.toString());
    var kullaniciFinalNot=int.parse(txt_kullaniciFinalNot.text.toString());

    var ortalama=((kullaniciVizeNot*50)/100)+((kullaniciFinalNot*50)/100);

    if ((ortalama>=0)&&(ortalama<30)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="FF";
    }else if ((ortalama>=30)&&(ortalama<40)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="DD";
    }else if ((ortalama>=40)&&(ortalama<50)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="DC";
    }else if ((ortalama>=50)&&(ortalama<70)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="CC";
    }else if ((ortalama>=70)&&(ortalama<90)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="BB";
    }else if ((ortalama>=90)&&(ortalama<100)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="BA";
    }else{
      kullaniciNotlari["kullaniciNot_HarfNot"]="AA";
    }

    refNotlar.push().set(kullaniciNotlari);
  }

  // İlgili kullanıcı notunun silinmesini sağlayacak metot
  Future<void> kullaniciNotSil(String kullaniciNot_Id) async {
    refNotlar.child(kullaniciNot_Id).remove();
  }

  // İlgili kullanıcı notunun güncellenmesini sağlayacak metot
  Future<void> kullaniciNotGuncelle(String kullaniciNot_Id,
      String kullaniciNot_VizeNot,String kullaniciNot_FinalNot ) async {

    var kullaniciNotlari=HashMap<String,dynamic>();
    kullaniciNotlari["kullaniciNot_VizeNot"]=kullaniciNot_VizeNot;
    kullaniciNotlari["kullaniciNot_FinalNot"]=kullaniciNot_FinalNot;

    var kullaniciVizeNot=int.parse(txt_kullaniciNotGuncelleVizeNot.text.toString());
    var kullaniciFinalNot=int.parse(txt_kullaniciNotGuncelleFinalNot.text.toString());

    var ortalama=((kullaniciVizeNot*50)/100)+((kullaniciFinalNot*50)/100);

    if ((ortalama>=0)&&(ortalama<30)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="FF";
    }else if ((ortalama>=30)&&(ortalama<40)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="DD";
    }else if ((ortalama>=40)&&(ortalama<50)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="DC";
    }else if ((ortalama>=50)&&(ortalama<70)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="CC";
    }else if ((ortalama>=70)&&(ortalama<90)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="BB";
    }else if ((ortalama>=90)&&(ortalama<100)){
      kullaniciNotlari["kullaniciNot_HarfNot"]="BA";
    }else{
      kullaniciNotlari["kullaniciNot_HarfNot"]="AA";
    }

    refNotlar.child(kullaniciNot_Id).update(kullaniciNotlari);
  }

  @override
  Widget build(BuildContext context) {
    // Sayfanın scroll olma özelliğini taşıması için tanımlanması gereken yapı
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Sabitler.SayfaCardListUstuBaslikUstBosluk,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Sabitler.SayfaCardListUstuBaslik("Öğrenci Notları"),
              ),
              Container(
                width: Sabitler.gecisEkraniIconButtonContainerGenislik,
                height: Sabitler.gecisEkraniIconButtonContainerYukseklik,
                decoration: BoxDecoration(
                  borderRadius: Sabitler.gecisEkraniIconButtonContainerBorderRadius,
                  color: Colors.teal,
                  boxShadow: [
                    Sabitler.GecisEkraniIconButtonContainerShadow(),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Kullanıcı notu eklemek için ilgili ikon ve popup
                    IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: Sabitler.gecisEkraniIconButtonAlertDialogBorderRadius,
                                ),
                                scrollable: true,
                                title: Sabitler.GecisEkraniIconButtonAlertDialogBaslik("Öğrenci Not Kaydı"),
                                content: Padding(
                                  padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "TC Kimlik", Colors.blue, "TC Kimlik No Giriniz",
                                            Icons.perm_identity_rounded, Colors.blue,
                                            TextInputType.number, txt_kullaniciNotKimlikNo,
                                            Colors.blue),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Öğrenci Adı Ve Soyadı", Colors.blue,
                                            "Öğrenci Adı Ve Soyadı Giriniz", Icons.person_rounded,
                                            Colors.blue, TextInputType.name, txt_kullaniciNotAdSoyad,
                                            Colors.blue),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Ders Adı", Colors.green, "Ders Adını Giriniz",
                                            Icons.play_lesson_rounded, Colors.green, TextInputType.text,
                                            txt_kullaniciNotDers, Colors.green),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Vize Not", Colors.red, "Vize Not Giriniz",
                                            Icons.grade_rounded, Colors.red, TextInputType.number,
                                            txt_kullaniciVizeNot, Colors.red),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Final Not", Colors.red, "Final Not Giriniz",
                                            Icons.grade_rounded, Colors.red, TextInputType.number,
                                            txt_kullaniciFinalNot, Colors.red),
                                      ],
                                    ),
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  Padding(
                                    padding: Sabitler.eklemeGuncellemeButtonPadding,
                                    child: SizedBox(
                                      width: Sabitler.eklemeGuncellemeButtonGenislik,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          if ((txt_kullaniciNotKimlikNo.text!="")&&
                                              (txt_kullaniciNotAdSoyad.text!="")&&
                                              (txt_kullaniciNotDers.text!="")&&
                                              (txt_kullaniciVizeNot.text!="")&&
                                              (txt_kullaniciFinalNot.text!="")){
                                            kullaniciNotKayit();
                                            txt_kullaniciNotKimlikNo.text="";
                                            txt_kullaniciNotAdSoyad.text="";
                                            txt_kullaniciNotDers.text="";
                                            txt_kullaniciVizeNot.text="";
                                            txt_kullaniciFinalNot.text="";
                                            Navigator.pop(context);
                                            Sabitler.ToastKisaSureliMesajDondur(
                                                "İlgili öğrenci not kartı eklendi."
                                            );
                                          }else{
                                            Sabitler.ToastKisaSureliMesajDondur(
                                                "Lütfen bilgileri eksiksiz biçimde doldurunuz!"
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: Sabitler.eklemeGuncellemeButtonBorderRadius,
                                          ),
                                          shadowColor: Sabitler.shadowRenk,
                                          elevation: Sabitler.eklemeGuncellemeButtonElevation,
                                        ),
                                        child: const Text(
                                          "Kaydet",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                      icon: Sabitler.eklemeIcon(),
                      padding: Sabitler.eklemeIconPadding,
                      color: Sabitler.eklemeIconColor,
                      hoverColor: Sabitler.eklemeIconHoverColor,
                      highlightColor: Sabitler.eklemeIconHighlightColor,
                      splashColor: Sabitler.eklemeIconSplashColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Sabitler.StreamBuilderUstBosluk,
          // Veri tabanında güncellenen ve silinen verilere anlık olarak ulaşmak
          // için kullandığımız yapı (StreamBuilder)
          StreamBuilder<DatabaseEvent>(
            stream: refNotlar.onValue,
            builder: (context,event){
              if (event.hasData){
                var notlarListesi=<KullaniciNotlari>[];
                var gelenNotlar=event.data!.snapshot.value as dynamic;
                if (gelenNotlar!=null){
                  gelenNotlar.forEach((key,nesne){
                    var gelenNot=KullaniciNotlari.fromJson(key,nesne);
                    notlarListesi.add(gelenNot);
                  });
                }else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Eğer mevcut veri tabanında ilgili tabloda veri yoksa
                      // göstereceğimiz animasyonlu bir lottie (Gif gibi düşüne-
                      // biliriz)
                      Sabitler.VeriYokAnimasyonuUstBosluk,
                      Sabitler.veriYokAnimasyonu("assets/not_found.json"),
                    ],
                  );
                }
                // İlgili tablodan gelen verileri performanslı bir biçimde liste-
                // leyeceğimiz bir liste yapısı
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: notlarListesi.length,
                  itemBuilder: (context,indeks){
                    var not=notlarListesi[indeks];
                    return PopupMenuButton(
                      elevation: Sabitler.eklemeGuncellemePopupMenuButtonElevation,
                      tooltip: "İlgili Öğrenci Not Kartı",
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: Sabitler.eklemeGuncellemePopupMenuButtonBorderRadius,
                      ),
                      offset: Sabitler.eklemeGuncellemePopupMenuButtonOffset,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Güncelle",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Sil",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      onCanceled: (){
                        debugPrint("Seçim yapılmadı.");
                      },
                      onSelected: (menuItemValue){
                        if (menuItemValue==1){
                          // Not güncelleme için kullanacağımız ilgili popup ya-
                          // pısı
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: Sabitler.
                                  gecisEkraniIconButtonAlertDialogBorderRadius,
                                ),
                                scrollable: true,
                                title: Sabitler.GecisEkraniIconButtonAlertDialogBaslik(
                                    "Öğrenci Not Güncelleme"
                                ),
                                content: Padding(
                                  padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Vize Not", Colors.red, "Vize Not Giriniz",
                                            Icons.grade_rounded, Colors.red, TextInputType.number,
                                            txt_kullaniciNotGuncelleVizeNot, Colors.red),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Final Not", Colors.red, "Final Not Giriniz",
                                            Icons.grade_rounded, Colors.red, TextInputType.number,
                                            txt_kullaniciNotGuncelleFinalNot, Colors.red),
                                      ],
                                    ),
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  Padding(
                                    padding: Sabitler.eklemeGuncellemeButtonPadding,
                                    child: SizedBox(
                                      width: Sabitler.eklemeGuncellemeButtonGenislik,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          if ((txt_kullaniciNotGuncelleVizeNot.text!="")&&
                                              (txt_kullaniciNotGuncelleFinalNot.text!="")){
                                            kullaniciNotGuncelle(not.kullaniciNot_Id,txt_kullaniciNotGuncelleVizeNot.text,
                                                txt_kullaniciNotGuncelleFinalNot.text);
                                            txt_kullaniciNotGuncelleVizeNot.text="";
                                            txt_kullaniciNotGuncelleFinalNot.text="";
                                            Navigator.pop(context);
                                            Sabitler.ToastKisaSureliMesajDondur(
                                                "İlgili öğrenci not kartı güncellendi."
                                            );
                                          }else{
                                            Sabitler.ToastKisaSureliMesajDondur(
                                                "Lütfen bilgileri eksiksiz biçimde doldurunuz!"
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: Sabitler.eklemeGuncellemeButtonBorderRadius,
                                          ),
                                          shadowColor: Sabitler.shadowRenk,
                                          elevation: Sabitler.eklemeGuncellemeButtonElevation,
                                        ),
                                        child: const Text(
                                          "Güncelle",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          );
                        }else{
                          // Not silmek için kullanacağımız yapı
                          kullaniciNotSil(not.kullaniciNot_Id);
                          Sabitler.ToastKisaSureliMesajDondur(
                              "İlgili öğrenci not kartı silindi."
                          );
                        }
                      },
                      child: Card(
                        semanticContainer: true,
                        margin: Sabitler.CardMargin,
                        shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.CardBorderRadius,
                        ),
                        elevation: Sabitler.CardElevation,
                        child: Padding(
                          padding: Sabitler.CardColumnPadding,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Sabitler.CardListBirinciYazi("Öğrenci Kimlik No: "),
                                  Sabitler.CardListIkinciYazi(not.kullaniciNot_Kimlik),
                                ],
                              ),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Öğrenci Ad Soyad"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(not.kullaniciNot_AdSoyad),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Ders"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(not.kullaniciNot_Ders),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Row(
                                children: [
                                  Sabitler.CardListBirinciYazi("Vize Not: "),
                                  Sabitler.CardListIkinciYazi(not.kullaniciNot_VizeNot),
                                ],
                              ),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Row(
                                children: [
                                  Sabitler.CardListBirinciYazi("Final Not: "),
                                  Sabitler.CardListIkinciYazi(not.kullaniciNot_FinalNot),
                                ],
                              ),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Row(
                                children: [
                                  Sabitler.CardListBirinciYazi("Harf Not: "),
                                  Sabitler.CardListIkinciYazi(not.kullaniciNot_HarfNot),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else{
                // Mevcut tablodaki verilerin gecikmeli gelmesinden doğacak sı-
                // kıntıyı bertaraf edecek,veriler gelene kadar (belli bir süre)
                // kullanıcıya bir loading animasyonu gösterecek yapı
                return Center(
                  child: Sabitler.SayfaVeriYokLoadingAnimasyon(Colors.teal),
                );
              }
            },
          ),
          Sabitler.StreamBuilderAltBosluk,
        ],
      ),
    );
  }
}