import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';

class UygulamaHakkindaEkrani extends StatefulWidget {
  const UygulamaHakkindaEkrani({Key? key}) : super(key: key);

  @override
  State<UygulamaHakkindaEkrani> createState() => _UygulamaHakkindaEkraniState();
}

class _UygulamaHakkindaEkraniState extends State<UygulamaHakkindaEkrani> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,right: 25.0),
            child: Container(
              width: double.infinity,
              height: 290,
              decoration: BoxDecoration(
                boxShadow: [
                  Sabitler.GecisEkraniDrawerListTileContainerShadow(),
                ],
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[300],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Sabitler.SayfaCardListUstuBaslik("Uygulama Hakkında"),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.5,right: 10.5),
                    child: Container(
                      width: double.infinity,
                      height: 198,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          Sabitler.GecisEkraniDrawerListTileContainerShadow(),
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17.0,right: 17.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Sabitler.UygulamaHakkindaYazi("Uygulama Adı: OBS"),
                            Sabitler.uygulamaHakkindaYaziAraBosluklar,
                            Sabitler.UygulamaHakkindaYazi("Sürüm Numarası: 1.0.0"),
                            Sabitler.uygulamaHakkindaYaziAraBosluklar,
                            Sabitler.UygulamaHakkindaYazi("Geliştirici: Alhas Atahan Kızılkaya"),
                            Sabitler.uygulamaHakkindaYaziAraBosluklar,
                            Sabitler.UygulamaHakkindaYazi("Platform: Atak Global Modular Platform"),
                            Sabitler.uygulamaHakkindaYaziAraBosluklar,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Sabitler.UygulamaHakkindaYazi("Uygulama Sayfası: "),
                                Image.asset("resimler/app_store.png",scale: 0.85,),
                                const SizedBox(width: 4,),
                                Image.asset("resimler/google_play_store.png",scale: 0.85,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}