// Firebase veri tabanında geçici kullanıcılar
// tablosu oluşturup bu tabloya veri eklemek için gereken geçici kullanıcılar servis sınıfı

class GeciciKullanicilar{

  String geciciKisi_id;
  String geciciKisi_tcKimlikNo;
  String geciciKisi_adSoyad;
  String geciciKisi_telNo;
  String geciciKisi_email;
  String geciciKisi_unvan;
  String geciciKisi_sifre;
  String geciciKisi_sayac;
  String geciciKisi_profilResim;

  // Constructor (Yapıcı metot)
  GeciciKullanicilar(this.geciciKisi_id,this.geciciKisi_tcKimlikNo,
      this.geciciKisi_adSoyad, this.geciciKisi_telNo, this.geciciKisi_email,
      this.geciciKisi_unvan,this.geciciKisi_sifre,this.geciciKisi_sayac,this.geciciKisi_profilResim);

  // Burada sınıf içerisinde tanımladığımız değişkenler bir json (map liste) formatında
  // geriye key value olarak döndürülüyor
  factory GeciciKullanicilar.fromJson(String key,Map<dynamic,dynamic> json){
    return GeciciKullanicilar(key,json["geciciKisi_tcKimlikNo"] as String,
        json["geciciKisi_adSoyad"] as String, json["geciciKisi_telNo"] as String,
        json["geciciKisi_email"] as String, json["geciciKisi_unvan"] as String,
        json["geciciKisi_sifre"] as String,json["geciciKisi_sayac"] as String,
    json["geciciKisi_profilResim"] as String);
  }
}