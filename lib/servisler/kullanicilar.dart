// Firebase veri tabanında kullanıcılar tablosu oluşturup bu tabloya veri
// eklemek için gereken kullanıcılar servis sınıfı

class Kullanicilar{

  String kisi_id;
  String kisi_tcKimlikNo;
  String kisi_adSoyad;
  String kisi_telNo;
  String kisi_email;
  String kisi_unvan;
  String kisi_sifre;
  String kisi_sayac;
  String kisi_profilResim;

  // Constructor (Yapıcı metot)
  Kullanicilar(this.kisi_id,this.kisi_tcKimlikNo, this.kisi_adSoyad,
      this.kisi_telNo, this.kisi_email,
      this.kisi_unvan,this.kisi_sifre,this.kisi_sayac,this.kisi_profilResim);

  // Burada sınıf içerisinde tanımladığımız değişkenler bir json (map liste) formatında
  // geriye key value olarak döndürülüyor
  factory Kullanicilar.fromJson(String key,Map<dynamic,dynamic> json){
    return Kullanicilar(key,json["kisi_tcKimlikNo"] as String, json["kisi_adSoyad"] as String,
        json["kisi_telNo"] as String,
        json["kisi_email"] as String,
        json["kisi_unvan"] as String,json["kisi_sifre"] as String,
        json["kisi_sayac"] as String,json["kisi_profilResim"] as String);
  }
}