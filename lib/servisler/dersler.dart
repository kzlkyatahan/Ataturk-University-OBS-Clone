// Firebase veri tabanında dersler tablosu oluşturup bu tabloya veri eklemek için
// gereken dersler servis sınıfı

class Dersler{
  String ders_Id;
  String ders_Ad;
  String ders_OgretimUyesiGorevlisi;
  String ders_OgretimUyesiGorevlisiKimlikNo;
  String ders_Kredi;
  String ders_Donem;

  // Constructor (Yapıcı metot)
  Dersler(this.ders_Id, this.ders_Ad, this.ders_OgretimUyesiGorevlisi,this.ders_OgretimUyesiGorevlisiKimlikNo,
      this.ders_Kredi, this.ders_Donem);

  // Burada sınıf içerisinde tanımladığımız değişkenler bir json (map liste) formatında
  // geriye key value olarak döndürülüyor
  factory Dersler.fromJson(String key,Map<dynamic,dynamic> json){
    return Dersler(key, json["ders_Ad"] as String,
    json["ders_OgretimUyesiGorevlisi"] as String,json["ders_OgretimUyesiGorevlisiKimlikNo"] as String, json["ders_Kredi"] as String,
    json["ders_Donem"] as String);
  }
}