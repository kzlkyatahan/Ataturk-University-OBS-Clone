import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:obs/sabitler/sabitler.dart';
import 'package:obs/servisler/gecici_kullanicilar.dart';

class YoneticiKullaniciOnaylariEkrani extends StatefulWidget {
  const YoneticiKullaniciOnaylariEkrani({Key? key}) : super(key: key);

  @override
  State<YoneticiKullaniciOnaylariEkrani> createState() => _YoneticiKullaniciOnaylariEkraniState();
}

class _YoneticiKullaniciOnaylariEkraniState extends State<YoneticiKullaniciOnaylariEkrani> {

  // İlgili veri tabanındaki tablodan veri almak için tabloyu referans olarak
  // gösterdiğimiz yapı
  var refGeciciKisiler=FirebaseDatabase.instance.ref().child("gecici_kullanicilar_tablo");

  // İlgili veri tabanında tablo oluşturmak için kullandığımız bir yapı
  var refKisiler=FirebaseDatabase.instance.ref().child("kullanicilar_tablo");


  // Kullanıcı kaydı yapmak için kullandığımız metot
  Future<void> kullaniciKayit(String kisi_tcKimlikNo,String kisi_adSoyad,String kisi_telNo,
      String kisi_email,String kisi_unvan,String kisi_sayac,String kisi_profilResim) async{

    var kullanicilar=HashMap<String,dynamic>();
    kullanicilar["kisi_id"]="";
    kullanicilar["kisi_tcKimlikNo"]=kisi_tcKimlikNo;
    kullanicilar["kisi_adSoyad"]=kisi_adSoyad;
    kullanicilar["kisi_telNo"]=kisi_telNo;
    kullanicilar["kisi_email"]=kisi_email;
    kullanicilar["kisi_unvan"]=kisi_unvan;
    kullanicilar["kisi_sifre"]=kisi_tcKimlikNo;
    kullanicilar["kisi_sayac"]=kisi_sayac;

    if (kisi_profilResim==""){
      kullanicilar["kisi_profilResim"]="";
    }else{
      kullanicilar["kisi_profilResim"]=kisi_profilResim;
    }

    refKisiler.push().set(kullanicilar);
  }

  // Geçici kaydı silmek için kullandığımız metot
  Future<void> geciciKayitSil(String geciciKisi_id) async {
    refGeciciKisiler.child(geciciKisi_id).remove();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Sabitler.SayfaCardListUstuBaslikUstBosluk,
          Sabitler.SayfaCardListUstuBaslik("Kullanıcı Onayları"),
          Sabitler.StreamBuilderUstBosluk,
          // Veri tabanında güncellenen ve silinen verilere anlık olarak ulaşmak
          // için kullandığımız yapı (StreamBuilder)
          StreamBuilder<DatabaseEvent>(
            stream: refGeciciKisiler.onValue,
            builder: (context,event){
              if (event.hasData){
                var geciciKullanicilarListesi=<GeciciKullanicilar>[];
                var gelenGeciciKullanicilar=event.data!.snapshot.value as dynamic;
                if (gelenGeciciKullanicilar!=null){
                  gelenGeciciKullanicilar.forEach((key,nesne){
                    var gelenGeciciKullanici=GeciciKullanicilar.fromJson(key, nesne);
                    geciciKullanicilarListesi.add(gelenGeciciKullanici);
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
                  itemCount: geciciKullanicilarListesi.length,
                  itemBuilder: (context,indeks){
                    var geciciKullanici=geciciKullanicilarListesi[indeks];
                    return PopupMenuButton(
                      tooltip: "İlgili Kullanıcı Bilgi Kartı",
                      elevation: Sabitler.eklemeGuncellemePopupMenuButtonElevation,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: Sabitler.eklemeGuncellemePopupMenuButtonBorderRadius,
                      ),
                      offset: Sabitler.eklemeGuncellemePopupMenuButtonOffset,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Onayla",
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
                          // İlgili kullanıcının kaydını onaylamak için kullandığımız
                          // yapı
                          kullaniciKayit(geciciKullanici.geciciKisi_tcKimlikNo,
                              geciciKullanici.geciciKisi_adSoyad,
                              geciciKullanici.geciciKisi_telNo,
                              geciciKullanici.geciciKisi_email,
                              geciciKullanici.geciciKisi_unvan,
                              geciciKullanici.geciciKisi_sayac,
                            geciciKullanici.geciciKisi_profilResim,
                          );

                          geciciKayitSil(geciciKullanici.geciciKisi_id);

                          Sabitler.ToastKisaSureliMesajDondur("Kullanıcı kaydı onaylandı.");

                        }else{
                          // İlgili kullanıcının kaydını geçici kayıtlardan silip onaya
                          // red verdiğimiz yapı
                          geciciKayitSil(geciciKullanici.geciciKisi_id);

                          Sabitler.ToastKisaSureliMesajDondur(
                              "Kullanıcı kaydı onaylanmadı.Geçici kayıt silindi."
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
                              Sabitler.CardListBirinciYazi("Kullanıcı TC Kimlik No"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(geciciKullanici.geciciKisi_tcKimlikNo),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Kullanıcı Ad Soyad"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(geciciKullanici.geciciKisi_adSoyad),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Kullanıcı Tel No"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(geciciKullanici.geciciKisi_telNo),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Kullanıcı Email"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(geciciKullanici.geciciKisi_email),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Kullanıcı Ünvan"),
                              Sabitler.CardListBirinciIkinciYaziArasiBosluk,
                              Sabitler.CardListIkinciYazi(geciciKullanici.geciciKisi_unvan),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Sabitler.CardListBirinciYazi("Kullanıcı Profil"),
                              Sabitler.CardListAyriYazilarArasiBosluk,
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    Sabitler.OrtakProfilResimShadow(),
                                  ],
                                  borderRadius: Sabitler.ortakProfilResimBorderRadius,
                                ),
                                child: geciciKullanici.geciciKisi_profilResim!="" ?
                                ClipRRect(
                                  borderRadius: Sabitler.ortakProfilResimBorderRadius,
                                  child: Image.network(
                                    geciciKullanici.geciciKisi_profilResim,
                                    fit: BoxFit.cover,
                                  ),
                                ) : ClipRRect(
                                  borderRadius: Sabitler.ortakProfilResimBorderRadius,
                                  child: Sabitler.OrtakProfilResimNullDegerResim(),
                                ),
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