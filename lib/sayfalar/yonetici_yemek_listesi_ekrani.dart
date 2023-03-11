import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/yemekler.dart';

class YoneticiYemekListesiEkrani extends StatefulWidget {
  const YoneticiYemekListesiEkrani({Key? key}) : super(key: key);

  @override
  State<YoneticiYemekListesiEkrani> createState() => _YoneticiYemekListesiEkraniState();
}

class _YoneticiYemekListesiEkraniState extends State<YoneticiYemekListesiEkrani> {

  TextEditingController txt_yemekListesi=TextEditingController();

  TextEditingController txt_yemekListesiGuncelleme=TextEditingController();

  // İlgili veri tabanında tablo oluşturmak için kullandığımız bir yapı
  var refYemekler=FirebaseDatabase.instance.ref().child("yemekler_tablo");

  // Yemek kaydını yapmak için kullandığımız metot
  Future<void> yemekKayit() async {
    var yemekler=HashMap<String,dynamic>();
    var tarih=DateTime.now();
    var gun=tarih.day;
    var ay=tarih.month;
    var yil=tarih.year;

    yemekler["yemek_Id"]="";
    yemekler["yemek_Liste"]=txt_yemekListesi.text.toString();
    yemekler["yemek_Tarihi"]="$gun/$ay/$yil";

    refYemekler.push().set(yemekler);
  }

  // İlgili yemek kaydını silmek için kullandığımız metot
  Future<void> yemekSil(String yemek_Id) async {
    refYemekler.child(yemek_Id).remove();
  }

  // İlgili yemek kaydını güncellemek için kullandığımız metot
  Future<void> yemekGuncelle(String yemek_Id,String yemek_Liste)
  async {
    var yemekler=HashMap<String,dynamic>();
    var tarih=DateTime.now();
    var gun=tarih.day;
    var ay=tarih.month;
    var yil=tarih.year;

    if (yemek_Liste!=""){
      yemekler["yemek_Liste"]=yemek_Liste;
      yemekler["yemek_Tarihi"]="$gun/$ay/$yil";
    }

    refYemekler.child(yemek_Id).update(yemekler);
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
                child: Sabitler.SayfaCardListUstuBaslik("Yemek Listesi"),
              ),
              Sabitler.yoneticiEkranBaslikEklemeIconArasiBosluk,
              Container(
                width: Sabitler.yoneticiIconContainerGenislik,
                height: Sabitler.yoneticiIconContainerYukseklik,
                decoration: BoxDecoration(
                    borderRadius: Sabitler.gecisEkraniIconButtonContainerBorderRadius,
                    color: Colors.deepOrange,
                    boxShadow: [
                      Sabitler.GecisEkraniIconButtonContainerShadow(),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // İlgili yemeği eklemek için kullandığımız ikon ve popup
                    // yapısı
                    IconButton(
                      onPressed: (){
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
                                    "Yemek Ekleme"
                                ),
                                content: Padding(
                                  padding: Sabitler.
                                  gecisEkraniIconButtonAlertDialogFormPadding,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                            "Yemek Listesi", Colors.deepOrange,
                                            "Yemek Listesi Giriniz", Icons.fastfood_rounded,
                                            Colors.deepOrange, TextInputType.text,
                                            txt_yemekListesi, Colors.deepOrange
                                        ),
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
                                          if (txt_yemekListesi.text!=""){
                                            yemekKayit();
                                            txt_yemekListesi.text="";
                                            Navigator.pop(context);
                                            Sabitler.ToastKisaSureliMesajDondur(
                                                "İlgili yemek kartı eklendi."
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
            stream: refYemekler.onValue,
            builder: (context,event){
              if (event.hasData){
                var yemeklerListesi=<Yemekler>[];
                var gelenYemekler=event.data!.snapshot.value as dynamic;
                if (gelenYemekler!=null){
                  gelenYemekler.forEach((key,nesne){
                    var gelenYemek=Yemekler.fromJson(key, nesne);
                    yemeklerListesi.add(gelenYemek);
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
                  itemCount: yemeklerListesi.length,
                  itemBuilder: (context,indeks){
                    var yemek=yemeklerListesi[indeks];
                    return PopupMenuButton(
                      tooltip: "İlgili Yemek Bilgi Kartı",
                      elevation: Sabitler.eklemeGuncellemePopupMenuButtonElevation,
                      color: Colors.deepOrange,
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
                          // İlgili yemeği güncelleyeceğimiz popup yapısı
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
                                      "Yemek Güncelleme"
                                  ),
                                  content: Padding(
                                    padding: Sabitler.gecisEkraniIconButtonAlertDialogFormPadding,
                                    child: Form(
                                      child: Column(
                                        children: [
                                          Sabitler.kullanicilarOrtakEklemeGuncellemeTextFormField(
                                              "Yemek Listesi", Colors.deepOrange,
                                              "Yemek Listesi Giriniz", Icons.fastfood_rounded,
                                              Colors.deepOrange, TextInputType.text,
                                              txt_yemekListesiGuncelleme, Colors.deepOrange),
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
                                            if (txt_yemekListesiGuncelleme.text!=""){
                                              yemekGuncelle(yemek.yemek_Id, txt_yemekListesiGuncelleme.text);
                                              txt_yemekListesiGuncelleme.text="";
                                              Navigator.pop(context);
                                              Sabitler.ToastKisaSureliMesajDondur(
                                                  "İlgili yemek kartı güncellendi."
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
                          // İlgili yemeği silebileceğimiz yapı
                          yemekSil(yemek.yemek_Id);
                          Sabitler.ToastKisaSureliMesajDondur("İlgili yemek kartı silindi.");
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
                                  Sabitler.CardListBirinciYazi("Yemek Tarihi: "),
                                  Sabitler.CardListIkinciYazi(yemek.yemek_Tarihi),
                                ],
                              ),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Yemek Listesi"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(yemek.yemek_Liste),
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
                  child: Sabitler.SayfaVeriYokLoadingAnimasyon(Colors.deepOrange),
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