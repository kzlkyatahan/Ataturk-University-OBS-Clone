// Firebase veri tabanında duyurular tablosu oluşturup bu tabloya veri eklemek için
// gereken duyurular servis sınıfı

class Duyurular{
  String duyuru_Id;
  String duyuru_Metni;
  String duyuru_Tarihi;

  // Constructor (Yapıcı metot)
  Duyurular(this.duyuru_Id,this.duyuru_Metni,this.duyuru_Tarihi);

  // Burada sınıf içerisinde tanımladığımız değişkenler bir json (map liste) formatında
  // geriye key value olarak döndürülüyor
  factory Duyurular.fromJson(String key,Map<dynamic,dynamic> json){
    return Duyurular(key,json["duyuru_Metni"] as String,json["duyuru_Tarihi"] as String);
  }
}