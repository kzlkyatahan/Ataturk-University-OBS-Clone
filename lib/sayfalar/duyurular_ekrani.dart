import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/duyurular.dart';

class DuyurularEkrani extends StatefulWidget {
  const DuyurularEkrani({Key? key}) : super(key: key);

  @override
  State<DuyurularEkrani> createState() => _DuyurularEkraniState();
}

class _DuyurularEkraniState extends State<DuyurularEkrani> {

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refDuyurular=FirebaseDatabase.instance.ref().child("duyurular_tablo");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Sabitler.SayfaCardListUstuBaslikUstBosluk,
          Sabitler.SayfaCardListUstuBaslik("Duyurular"),
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