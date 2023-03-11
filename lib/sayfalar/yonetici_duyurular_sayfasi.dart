import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/duyurular.dart';

class YoneticiDuyurularEkrani extends StatefulWidget {
  const YoneticiDuyurularEkrani({Key? key}) : super(key: key);

  @override
  State<YoneticiDuyurularEkrani> createState() => _YoneticiDuyurularEkraniState();
}

class _YoneticiDuyurularEkraniState extends State<YoneticiDuyurularEkrani> {

  TextEditingController txt_duyuruMetni=TextEditingController();

  TextEditingController txt_duyuruMetniGuncelleme=TextEditingController();


  // İlgili veri tabanında tablo oluşturmak için kullandığımız bir yapı
  var refDuyurular=FirebaseDatabase.instance.ref().child("duyurular_tablo");


  // İlgili duyuruyu tabloya kaydetmek için kullandığımız metot
  Future<void> duyuruKayit() async {
    var duyurular=HashMap<String,dynamic>();
    var tarih=DateTime.now();
    var gun=tarih.day;
    var ay=tarih.month;
    var yil=tarih.year;
    var saat=tarih.hour;
    var dakika;

    if (tarih.minute<10){
      setState(() {
        dakika="0${tarih.minute}";
      });
    }if (tarih.minute>=10){
      setState(() {
        dakika="${tarih.minute}";
      });
    }

    duyurular["duyuru_Id"]="";
    duyurular["duyuru_Metni"]=txt_duyuruMetni.text.toString();
    duyurular["duyuru_Tarihi"]="$gun/$ay/$yil,"
        "$saat:$dakika";

    refDuyurular.push().set(duyurular);
  }

  // İlgili duyuruyu silmek için kullandığımız bir metot
  Future<void> duyuruSil(String duyuru_Id) async {
    refDuyurular.child(duyuru_Id).remove();
  }

  // İlgili duyuruyu güncellemek için kullandığımız metot
  Future<void> duyuruGuncelle(String duyuru_Id,String duyuru_Metni)
  async {
    var duyurular=HashMap<String,dynamic>();
    var tarih=DateTime.now();
    var gun=tarih.day;
    var ay=tarih.month;
    var yil=tarih.year;
    var saat=tarih.hour;
    var dakika;

    if (tarih.minute<10){
      setState(() {
        dakika="0${tarih.minute}";
      });
    }if (tarih.minute>=10){
      setState(() {
        dakika=tarih.minute;
      });
    }

    if (duyuru_Metni!=""){
      duyurular["duyuru_Metni"]=duyuru_Metni;
      duyurular["duyuru_Tarihi"]="$gun/$ay/$yil,"
          "$saat:$dakika";
    }

    refDuyurular.child(duyuru_Id).update(duyurular);
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
                child: Sabitler.SayfaCardListUstuBaslik("Duyurular"),
              ),
              Sabitler.yoneticiEkranBaslikEklemeIconArasiBosluk,
              Container(
                width: Sabitler.yoneticiIconContainerGenislik,
                height: Sabitler.yoneticiIconContainerYukseklik,
                decoration: BoxDecoration(
                    borderRadius: Sabitler.gecisEkraniIconButtonContainerBorderRadius,
                    color: Colors.brown,
                    boxShadow: [
                      Sabitler.GecisEkraniIconButtonContainerShadow(),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // İlgili duyuruyu eklemek için kullandığımız ikon ve popup
                    IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: Sabitler.
                                  gecisEkraniIconButtonAlertDialogBorderRadius
                                ),
                                scrollable: true,
                                title: Sabitler.GecisEkraniIconButtonAlertDialogBaslik("Duyuru Ekleme"),
                                content: Padding(
                                  padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Duyuru Metni", Colors.blue,
                                            "Duyuru Metni Giriniz", Icons.text_snippet_rounded,
                                            Colors.blue, TextInputType.text,
                                            txt_duyuruMetni, Colors.blue),
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
                                          if (txt_duyuruMetni.text!=""){
                                            duyuruKayit();
                                            txt_duyuruMetni.text="";
                                            Navigator.pop(context);
                                            Sabitler.ToastKisaSureliMesajDondur("İlgili duyuru kartı eklendi.");
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
            stream: refDuyurular.onValue,
            builder: (context,event){
              if (event.hasData){
                var duyurularListesi=<Duyurular>[];
                var gelenDuyurular=event.data!.snapshot.value as dynamic;
                if (gelenDuyurular!=null){
                  gelenDuyurular.forEach((key,nesne){
                    var gelenDuyuru=Duyurular.fromJson(key, nesne);
                    duyurularListesi.add(gelenDuyuru);
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
                  itemCount: duyurularListesi.length,
                  itemBuilder: (context,indeks){
                    var duyuru=duyurularListesi[indeks];
                    return PopupMenuButton(
                      tooltip: "İlgili Duyuru Bilgi Kartı",
                      elevation: Sabitler.eklemeGuncellemePopupMenuButtonElevation,
                      color: Colors.brown,
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
                        // İlgili duyuruyu güncellemek için kullandığımız bir popup
                        // yapısı
                        if (menuItemValue==1){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: Sabitler.
                                    gecisEkraniIconButtonAlertDialogBorderRadius,
                                  ),
                                  scrollable: true,
                                  title: Sabitler.
                                  GecisEkraniIconButtonAlertDialogBaslik("Duyuru Güncelleme"),
                                  content: Padding(
                                    padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                    child: Form(
                                      child: Column(
                                        children: [
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Duyuru Metni", Colors.blue,
                                              "Duyuru Metni Giriniz", Icons.text_snippet_rounded,
                                              Colors.blue, TextInputType.text,
                                              txt_duyuruMetniGuncelleme, Colors.blue),
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
                                            if (txt_duyuruMetniGuncelleme.text!=""){
                                              duyuruGuncelle(duyuru.duyuru_Id, txt_duyuruMetniGuncelleme.text);
                                              txt_duyuruMetniGuncelleme.text="";
                                              Navigator.pop(context);
                                              Sabitler.ToastKisaSureliMesajDondur(
                                                  "İlgili duyuru kartı güncellendi."
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
                          // İlgili duyuruyu silmek için kullandığımız yapı
                          duyuruSil(duyuru.duyuru_Id);
                          Sabitler.ToastKisaSureliMesajDondur("İlgili duyuru kartı silindi.");
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
                                  Sabitler.CardListBirinciYazi("Duyuru Tarihi: "),
                                  Sabitler.CardListIkinciYazi(duyuru.duyuru_Tarihi),
                                ],
                              ),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Duyuru"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(duyuru.duyuru_Metni),
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
                  child: Sabitler.SayfaVeriYokLoadingAnimasyon(Colors.brown),
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