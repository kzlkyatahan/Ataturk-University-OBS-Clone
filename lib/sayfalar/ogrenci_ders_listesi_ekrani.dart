import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/dersler.dart';

class OgrenciDersListesiEkrani extends StatefulWidget {

  String kisiKimlikNo;
  String kisiId;
  String kisiAdSoyad;
  String kisiUnvan;
  String kisiSayac;
  String kisiSifre;

  OgrenciDersListesiEkrani({Key? key,required this.kisiKimlikNo,
  required this.kisiId,required this.kisiAdSoyad,required this.kisiUnvan,
  required this.kisiSayac,required this.kisiSifre}) : super(key: key);

  @override
  State<OgrenciDersListesiEkrani> createState() => _OgrenciDersListesiEkraniState();
}

class _OgrenciDersListesiEkraniState extends State<OgrenciDersListesiEkrani> {

  TextEditingController txt_sifre_yenileme=TextEditingController();

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refDersler=FirebaseDatabase.instance.ref().child("dersler_tablo");
  var refKisiler=FirebaseDatabase.instance.ref().child("kullanicilar_tablo");


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Sabitler.SayfaCardListUstuBaslikUstBosluk,
          Sabitler.SayfaCardListUstuBaslik("Ders Listesi"),
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
                            Sabitler.CardListBirinciYazi("Ders Adı"),
                            Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                            Sabitler.CardListIkinciYazi(ders.ders_Ad),
                            Sabitler.CardListAyriYazilarArasiBosluk,
                            Sabitler.CardListBirinciYazi("Öğretim Üyesi/Görevlisi"),
                            Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                            Sabitler.CardListIkinciYazi(ders.ders_OgretimUyesiGorevlisi),
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