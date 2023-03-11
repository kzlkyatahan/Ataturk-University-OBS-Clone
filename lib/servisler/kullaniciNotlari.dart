// Firebase veri tabanında kullanıcı notları tablosu oluşturup bu tabloya veri
// eklemek için gereken kullanıcı notları servis sınıfı

class KullaniciNotlari{

  String kullaniciNot_Id;
  String kullaniciNot_Kimlik;
  String kullaniciNot_AdSoyad;
  String kullaniciNot_Ders;
  String kullaniciNot_VizeNot;
  String kullaniciNot_FinalNot;
  String kullaniciNot_HarfNot;

  // Constructor (Yapıcı metot)
  KullaniciNotlari(this.kullaniciNot_Id,this.kullaniciNot_Kimlik, this.kullaniciNot_AdSoyad,
      this.kullaniciNot_Ders, this.kullaniciNot_VizeNot,
      this.kullaniciNot_FinalNot,this.kullaniciNot_HarfNot);

  // Burada sınıf içerisinde tanımladığımız değişkenler bir json (map liste) formatında
  // geriye key value olarak döndürülüyor
  factory KullaniciNotlari.fromJson(String key,Map<dynamic,dynamic> json){
    return KullaniciNotlari(key,json["kullaniciNot_Kimlik"] as String,
        json["kullaniciNot_AdSoyad"] as String, json["kullaniciNot_Ders"] as String,
        json["kullaniciNot_VizeNot"] as String,
        json["kullaniciNot_FinalNot"] as String,json["kullaniciNot_HarfNot"] as String);
  }

}