import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/kullaniciNotlari.dart';

class OgrenciNotlarEkrani extends StatefulWidget {

  String kisiAdSoyad;
  String kisiKimlikNo;
  String kisiId;


  OgrenciNotlarEkrani({Key? key,required this.kisiAdSoyad,required this.kisiKimlikNo,required this.kisiId}) : super(key: key);

  @override
  State<OgrenciNotlarEkrani> createState() => _OgrenciNotlarEkraniState();
}

class _OgrenciNotlarEkraniState extends State<OgrenciNotlarEkrani> {

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refNotlar=FirebaseDatabase.instance.ref().child("notlar_tablo");


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Sabitler.SayfaCardListUstuBaslikUstBosluk,
          Sabitler.SayfaCardListUstuBaslik("Notlar"),
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

                    if (gelenNot.kullaniciNot_Kimlik==widget.kisiKimlikNo){
                      notlarListesi.add(gelenNot);
                    }

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
                    return Card(
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