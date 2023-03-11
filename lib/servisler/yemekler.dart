// Firebase veri tabanında yemekler tablosu oluşturup bu tabloya veri
// eklemek için gereken yemekler servis sınıfı

class Yemekler{
  String yemek_Id;
  String yemek_Tarihi;
  String yemek_Liste;

  // Constructor (Yapıcı metot)
  Yemekler(this.yemek_Id, this.yemek_Tarihi, this.yemek_Liste);

  // Burada sınıf içerisinde tanımladığımız değişkenler bir json (map liste) formatında
  // geriye key value olarak döndürülüyor
  factory Yemekler.fromJson(String key,Map<dynamic,dynamic> json){
    return Yemekler(key, json["yemek_Tarihi"] as String, json["yemek_Liste"] as String);
  }
}