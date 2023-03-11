import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/yemekler.dart';

class YemekListesiEkrani extends StatefulWidget {
  const YemekListesiEkrani({Key? key}) : super(key: key);

  @override
  State<YemekListesiEkrani> createState() => _YemekListesiEkraniState();
}

class _YemekListesiEkraniState extends State<YemekListesiEkrani> {

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refYemekler=FirebaseDatabase.instance.ref().child("yemekler_tablo");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Sabitler.SayfaCardListUstuBaslikUstBosluk,
          Sabitler.SayfaCardListUstuBaslik("Yemek Listesi"),
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
                    var tarih=DateTime.now();
                    var gun=tarih.day;
                    var ay=tarih.month;
                    var yil=tarih.year;
                    var tamTarih="$gun/$ay/$yil";

                    var gelenYemek=Yemekler.fromJson(key, nesne);

                    if(gelenYemek.yemek_Tarihi==tamTarih){
                      yemeklerListesi.add(gelenYemek);
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
                  itemCount: yemeklerListesi.length,
                  itemBuilder: (context,indeks){
                    var yemek=yemeklerListesi[indeks];
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