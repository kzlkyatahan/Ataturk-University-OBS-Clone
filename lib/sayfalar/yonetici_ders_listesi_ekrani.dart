import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/dersler.dart';


class YoneticiDersListesiEkrani extends StatefulWidget {

  const YoneticiDersListesiEkrani({Key? key}) : super(key: key);

  @override
  State<YoneticiDersListesiEkrani> createState() => _YoneticiDersListesiEkraniState();
}

class _YoneticiDersListesiEkraniState extends State<YoneticiDersListesiEkrani>{

  TextEditingController txt_dersAdi=TextEditingController();
  TextEditingController txt_dersOgretimUyesiGorevlisi=TextEditingController();
  TextEditingController txt_dersOgretimUyesiGorevlisiKimlikNo=TextEditingController();
  TextEditingController txt_dersKredi=TextEditingController();
  TextEditingController txt_dersDonem=TextEditingController();

  TextEditingController txt_dersAdiGuncelleme=TextEditingController();
  TextEditingController txt_dersOgretimUyesiGorevlisiGuncelleme=TextEditingController();
  TextEditingController txt_dersOgretimUyesiGorevlisiKimlikNoGuncelleme=TextEditingController();
  TextEditingController txt_dersKrediGuncelleme=TextEditingController();
  TextEditingController txt_dersDonemGuncelleme=TextEditingController();


  // İlgili veri tabanında tablo oluşturmak için kullandığımız bir yapı
  var refDersler=FirebaseDatabase.instance.ref().child("dersler_tablo");

  // İlgili ders kartını tabloya kaydetmek için kullandığımız metot
  Future<void> dersKayit() async{
    var dersler=HashMap<String,dynamic>();
    dersler["ders_Id"]="";
    dersler["ders_Ad"]=txt_dersAdi.text.toString();
    dersler["ders_OgretimUyesiGorevlisi"]=txt_dersOgretimUyesiGorevlisi.text.toString();
    dersler["ders_OgretimUyesiGorevlisiKimlikNo"]=txt_dersOgretimUyesiGorevlisiKimlikNo.text.toString();
    dersler["ders_Kredi"]=txt_dersKredi.text.toString();
    dersler["ders_Donem"]=txt_dersDonem.text.toString();

    refDersler.push().set(dersler);
  }

  // İlgili ders kartını silmek için kullandığımız metot
  Future<void> dersSil(String ders_Id) async {
    refDersler.child(ders_Id).remove();
  }

  // İlgili ders kartını güncellemek için kullandığımız metot
  Future<void> dersGuncelle(String ders_Id,String ders_Ad,
      String ders_OgretimUyesiGorevlisi,String ders_Kredi,String ders_Donem,String ders_OgretimUyesiGorevlisiKimlikNo)
  async {
    var dersler=HashMap<String,dynamic>();

    if (ders_Ad!=""){
      dersler["ders_Ad"]=ders_Ad;
    }
    if (ders_OgretimUyesiGorevlisi!=""){
      dersler["ders_OgretimUyesiGorevlisi"]=ders_OgretimUyesiGorevlisi;
    }
    if (ders_Kredi!=""){
      dersler["ders_Kredi"]=ders_Kredi;
    }
    if (ders_Donem!=""){
      dersler["ders_Donem"]=ders_Donem;
    }
    if (ders_OgretimUyesiGorevlisiKimlikNo!=""){
      dersler["ders_OgretimUyesiGorevlisiKimlikNo"]=ders_OgretimUyesiGorevlisiKimlikNo;
    }

    refDersler.child(ders_Id).update(dersler);
  }

  
  @override
  Widget build(BuildContext context) {
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
                child: Sabitler.SayfaCardListUstuBaslik("Dersler"),
              ),
              Sabitler.yoneticiEkranBaslikEklemeIconArasiBosluk,
              Container(
                width: Sabitler.yoneticiIconContainerGenislik,
                height: Sabitler.yoneticiIconContainerYukseklik,
                decoration: BoxDecoration(
                    borderRadius: Sabitler.gecisEkraniIconButtonContainerBorderRadius,
                    color: Colors.blue,
                    boxShadow: [
                      Sabitler.GecisEkraniIconButtonContainerShadow(),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ders eklemek için ilgili ikon ve popup yapısı
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
                                title: Sabitler.GecisEkraniIconButtonAlertDialogBaslik("Ders Ekleme"),
                                content: Padding(
                                  padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Ders Adı", Colors.blue, "Ders Adı Giriniz",
                                            Icons.play_lesson_rounded, Colors.blue, TextInputType.name,
                                            txt_dersAdi, Colors.blue),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Öğretim Üyesi/Görevlisi", Colors.blue, "Öğretim Üyesi/Görevlisi Adı Ve Soyadı Giriniz",
                                            Icons.person_rounded, Colors.blue, TextInputType.name,
                                            txt_dersOgretimUyesiGorevlisi, Colors.blue),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Öğretim Üyesi/Görevlisi Kimlik No", Colors.blue,
                                            "Öğretim Üyesi/Görevlisi Kimlik No Giriniz",
                                            Icons.perm_identity_rounded, Colors.blue, TextInputType.number,
                                            txt_dersOgretimUyesiGorevlisiKimlikNo, Colors.blue),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Ders Kredi", Colors.green, "Ders Kredisini Giriniz",
                                            Icons.confirmation_number_rounded, Colors.green, TextInputType.number,
                                            txt_dersKredi, Colors.green),
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Dönem", Colors.red, "Dönem Giriniz",
                                            Icons.date_range_rounded, Colors.red, TextInputType.number,
                                            txt_dersDonem, Colors.red),
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
                                          if ((txt_dersAdi.text!="")&&
                                              (txt_dersOgretimUyesiGorevlisi.text!="")&&
                                              (txt_dersOgretimUyesiGorevlisiKimlikNo.text!="")&&
                                              (txt_dersKredi.text!="")&&(txt_dersDonem.text!="")){
                                            dersKayit();
                                            txt_dersAdi.text="";
                                            txt_dersOgretimUyesiGorevlisi.text="";
                                            txt_dersOgretimUyesiGorevlisiKimlikNo.text="";
                                            txt_dersKredi.text="";
                                            txt_dersDonem.text="";
                                            Navigator.pop(context);
                                            Sabitler.ToastKisaSureliMesajDondur("İlgili ders kartı eklendi.");
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
                                          "Ekle",
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
            stream: refDersler.onValue,
            builder: (context,event){
              if (event.hasData){
                var derslerListesi=<Dersler>[];
                var gelenDersler=event.data!.snapshot.value as dynamic;
                if (gelenDersler!=null){
                  gelenDersler.forEach((key,nesne){
                    var gelenDers=Dersler.fromJson(key, nesne);
                    derslerListesi.add(gelenDers);
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
                  itemCount: derslerListesi.length,
                  itemBuilder: (context,indeks){
                    var ders=derslerListesi[indeks];
                    return PopupMenuButton(
                      tooltip: "İlgili Ders Bilgi Kartı",
                      elevation: Sabitler.eklemeGuncellemePopupMenuButtonElevation,
                      color: Colors.blue,
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
                          // Ders güncellemek için kullandığımız ilgili popup
                          // yapısı
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: Sabitler.
                                    gecisEkraniIconButtonAlertDialogBorderRadius
                                  ),
                                  scrollable: true,
                                  title: Sabitler.
                                      GecisEkraniIconButtonAlertDialogBaslik(
                                      "Ders Güncelleme"
                                  ),
                                  content: Padding(
                                    padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                    child: Form(
                                      child: Column(
                                        children: [
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Ders Adı", Colors.blue, "Ders Adı Giriniz",
                                              Icons.play_lesson_rounded, Colors.blue, TextInputType.name,
                                              txt_dersAdiGuncelleme, Colors.blue),
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Öğretim Üyesi/Görevlisi", Colors.blue,
                                              "Öğretim Üyesi/Görevlisi Adı Ve Soyadı Giriniz", Icons.person_rounded,
                                              Colors.blue, TextInputType.name,
                                              txt_dersOgretimUyesiGorevlisiGuncelleme, Colors.blue),
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Öğretim Üyesi/Görevlisi Kimlik No", Colors.blue,
                                              "Öğretim Üyesi/Görevlisi Kimlik No Giriniz", Icons.person_rounded,
                                              Colors.blue, TextInputType.number,
                                              txt_dersOgretimUyesiGorevlisiKimlikNoGuncelleme, Colors.blue),
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Ders Kredi", Colors.green,
                                              "Ders Kredisini Giriniz", Icons.confirmation_number_rounded,
                                              Colors.green, TextInputType.number,
                                              txt_dersKrediGuncelleme, Colors.green),
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Dönem", Colors.red,
                                              "Dönem Giriniz", Icons.date_range_rounded,
                                              Colors.red, TextInputType.number,
                                              txt_dersDonemGuncelleme, Colors.red),
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
                                            dersGuncelle(ders.ders_Id, txt_dersAdiGuncelleme.text,
                                                txt_dersOgretimUyesiGorevlisiGuncelleme.text,
                                                txt_dersKrediGuncelleme.text, txt_dersDonemGuncelleme.text,
                                            txt_dersOgretimUyesiGorevlisiKimlikNoGuncelleme.text);
                                            txt_dersAdiGuncelleme.text="";
                                            txt_dersOgretimUyesiGorevlisiGuncelleme.text="";
                                            txt_dersOgretimUyesiGorevlisiKimlikNoGuncelleme.text="";
                                            txt_dersKrediGuncelleme.text="";
                                            txt_dersDonemGuncelleme.text="";
                                            Navigator.pop(context);
                                            Sabitler.ToastKisaSureliMesajDondur("İlgili ders kartı güncellendi.");
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
                          // Ders silmek için kullandığımız ilgili yapı
                          dersSil(ders.ders_Id);
                          Sabitler.ToastKisaSureliMesajDondur("İlgili ders kartı silindi.");
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
                              Sabitler.CardListBirinciYazi("Ders Adı"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(ders.ders_Ad),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Öğretim Üyesi/Görevlisi"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(ders.ders_OgretimUyesiGorevlisi),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Öğretim Üyesi/Görevlisi Kimlik No"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(ders.ders_OgretimUyesiGorevlisiKimlikNo),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Row(
                                children: [
                                  Sabitler.CardListBirinciYazi("Ders Kredi: "),
                                  Sabitler.CardListIkinciYazi(ders.ders_Kredi),
                                ],
                              ),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Row(
                                children: [
                                  Sabitler.CardListBirinciYazi("Ders Dönem: "),
                                  Sabitler.CardListIkinciYazi(ders.ders_Donem),
                                ],
                              )
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
                  child: Sabitler.SayfaVeriYokLoadingAnimasyon(Colors.blue),
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