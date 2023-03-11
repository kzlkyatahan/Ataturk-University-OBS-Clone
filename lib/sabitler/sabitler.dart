import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

/* Sabitleri kullanmamızda ki genel amaç oluşturduğumuz uygulama yapısına
modülerlik katmak,genel anlamda uygulama stabilitesini ve performans optimi-
zasyonunu arttırmak
 */

class Sabitler{

  // Genel anlamda ortak kullanılan sabitler

  static final Color shadowRenk=Colors.grey[400]!;
  static final Color txtRenk=Colors.blueGrey[900]!;
  static const SizedBox StreamBuilderAltBosluk=SizedBox(height: 10,);
  static const SizedBox StreamBuilderUstBosluk=SizedBox(height: 16,);
  static const SizedBox CardListBirinciIkinciYaziArasiBosluk=SizedBox(height: 4,);
  static const SizedBox CardListAyriYazilarArasiBosluk=SizedBox(height: 8,);
  static const SizedBox VeriYokAnimasyonuUstBosluk=SizedBox(height: 100,);
  static const SizedBox SayfaCardListUstuBaslikUstBosluk=SizedBox(height: 20,);
  static const EdgeInsets CardColumnPadding=EdgeInsets.all(12.0);
  static var CardElevation=5.0;
  static final BorderRadius CardBorderRadius=BorderRadius.circular(12.0);
  static const EdgeInsets CardMargin=EdgeInsets.only(top: 8.0,bottom: 8.0,left: 14.0,right: 14.0);
  static const EdgeInsets OrtakTextFieldPadding=EdgeInsets.only(left: 24.0,right: 24.0);
  static const Color OrtakTextFieldContainerColor=Colors.transparent;
  static final BorderRadius OrtakTextFieldContainerBorderRadius=BorderRadius.circular(15.0);
  static double girisEkraniOrtakButtonYukseklik=41;
  static double girisEkraniOrtakButtonGenislik=120;
  static const Color girisEkraniOrtakButtonBackgroundColor=Colors.teal;
  static final BorderRadius girisEkraniOrtakButtonBorderRadius=BorderRadius.circular(12.0);
  static final BorderRadius ortakProfilResimBorderRadius=BorderRadius.circular(80.0);
  static final BorderRadius sifreYenilemeAlertDialogBorderRadius=BorderRadius.circular(12.0);
  static var girisEkraniOrtakButtonElevation=10.0;
  static const SizedBox girisEkraniTextFieldBosluk=SizedBox(height: 25,);
  static const EdgeInsets sifreYenilemeAlertDialogFormPadding=EdgeInsets.all(8.0);
  static const EdgeInsets sifreYenilemeButtonPadding=EdgeInsets.only(bottom: 5.0);
  static double sifreYenilemeButtonYukseklik=38;
  static double sifreYenilemeButtonGenislik=110;
  static final BorderRadius sifreYenilemeButtonBorderRadius=BorderRadius.circular(15.0);
  static var sifreYenilemeButtonElevation=6.0;
  static const BorderRadius gecisEkraniAppBarBorderRadius=BorderRadius.only(
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0)
  );
  static var gecisEkraniAppBarElevation=8.0;
  static const EdgeInsets gecisEkraniAppBarActionsIconPadding=EdgeInsets.only(right: 15.0);
  static final BorderRadius gecisEkraniDrawerBorderRadius=BorderRadius.circular(15.0);
  static double gecisEkraniDrawerGenislik=255;
  static const SizedBox gecisEkraniDrawerElemanlarUstBosluk=SizedBox(height: 40,);
  static const SizedBox gecisEkraniDrawerProfilResimBilgilerArasiBosluk=SizedBox(height: 15,);
  static const SizedBox gecisEkraniDrawerKisiAdSoyadUnvanArasiBosluk=SizedBox(height: 5,);
  static const SizedBox gecisEkraniDrawerKisiUnvanListTileArasiBosluk=SizedBox(height: 20,);
  static const EdgeInsets gecisEkraniDrawerListTileContainerPadding=EdgeInsets.only(left: 15.0,
      right: 15.0);
  static double gecisEkraniDrawerListTileContainerYukseklik=400;
  static Color? gecisEkraniDrawerListTileContainerRenk=Colors.grey[300];
  static final BorderRadius gecisEkraniDrawerListTileContainerBorderRadius=
  BorderRadius.circular(15.0);
  static const SizedBox gecisEkraniDrawerListTileUstBosluk=SizedBox(height: 10,);
  static final BorderRadius gecisEkraniDrawerListTileBorderRadius=BorderRadius.circular(15.0);
  static const SizedBox gecisEkraniDrawerCikisYapListTileUstBosluk=SizedBox(height: 50,);
  static const SizedBox gecisEkraniDrawerListTileAltBosluk=SizedBox(height: 20,);
  static final BorderRadius gecisEkraniCikisPopUpAlertDialogBorderRadius=BorderRadius.circular(10.0);
  static double gecisEkraniIconButtonContainerGenislik=50;
  static double gecisEkraniIconButtonContainerYukseklik=40;
  static final BorderRadius gecisEkraniIconButtonContainerBorderRadius=BorderRadius.circular(10.0);
  static final BorderRadius gecisEkraniIconButtonAlertDialogBorderRadius=BorderRadius.circular(12.0);
  static const EdgeInsets gecisEkraniIconButtonAlertDialogFormPadding=EdgeInsets.all(8.0);
  static const EdgeInsets eklemeGuncellemeButtonPadding=EdgeInsets.only(bottom: 5.0);
  static double eklemeGuncellemeButtonGenislik=90;
  static final BorderRadius eklemeGuncellemeButtonBorderRadius=BorderRadius.circular(15.0);
  static double eklemeGuncellemeButtonElevation=6;
  static const EdgeInsets eklemeIconPadding=EdgeInsets.zero;
  static const Color eklemeIconColor=Colors.white;
  static const Color eklemeIconHoverColor=Colors.transparent;
  static const Color eklemeIconHighlightColor=Colors.transparent;
  static const Color eklemeIconSplashColor=Colors.transparent;
  static double eklemeGuncellemePopupMenuButtonElevation=5;
  static final BorderRadius eklemeGuncellemePopupMenuButtonBorderRadius=
  BorderRadius.circular(10.0);
  static const Offset eklemeGuncellemePopupMenuButtonOffset=Offset(2,8);
  static const SizedBox uygulamaHakkindaYaziAraBosluklar=SizedBox(height: 10,);
  static const SizedBox yoneticiEkranBaslikEklemeIconArasiBosluk=SizedBox(width: 5,);
  static double yoneticiIconContainerGenislik=50;
  static double yoneticiIconContainerYukseklik=36;

  // Genel anlamda ortak kullanılan metot ve yapılar

  static Widget UygulamaHakkindaYazi(String yaziMetni){
    return Text(
      yaziMetni,
      style: GoogleFonts.akayaKanadaka(
        textStyle: const TextStyle(fontSize: 19),
        color: Colors.white,
      ),
    );
  }

  static Widget eklemeIcon(){
    return const Icon(
      Icons.add_circle_outline_rounded,
    );
  }

  static Widget GecisEkraniIconButtonAlertDialogBaslik(String yaziMetni){
    return Center(
      child: Text(
        yaziMetni,
      ),
    );
  }

  static Widget GecisEkraniDrawerListTileIcon(IconData icon,Color renk){
    return Icon(
      icon,
      size: 32,
      color: renk,
    );
  }

  static Widget GecisEkraniDrawerListTileBaslik(String yaziMetni){
    return Text(
      yaziMetni,
      style: GoogleFonts.akayaKanadaka(
          textStyle: const TextStyle(
            fontSize: 18.5,
          )
      ),
    );
  }

  static BoxShadow GecisEkraniIconButtonContainerShadow(){
    return BoxShadow(
      color: Sabitler.shadowRenk,
      offset: const Offset(0, 7),
      blurRadius: 8,
    );
  }

  static BoxShadow GecisEkraniDrawerListTileContainerShadow(){
    return BoxShadow(
      color: Sabitler.shadowRenk,
      blurRadius: 10,
      offset: const Offset(0, 7),
    );
  }

  static Widget OrtakProfilResimNullDegerResim(){
    return Image.asset(
      "resimler/user.png",
      fit: BoxFit.cover,
    );
  }

  static Widget GecisEkraniDrawerKisiAdSoyad(String yaziMetni){
    return Text(
        yaziMetni,
        style: GoogleFonts.akayaKanadaka(
          textStyle: const TextStyle(fontSize: 20),
        )
    );
  }

  static Widget GecisEkraniDrawerKisiUnvan(String yaziMetni){
    return Text(
        "(${yaziMetni})",
        style: GoogleFonts.akayaKanadaka(
          textStyle: const TextStyle(fontSize: 18),
        )
    );
  }

  static Widget GecisEkraniAppBarBaslik(String yaziMetni){
    return Text(
      yaziMetni,
      style: GoogleFonts.akayaKanadaka(
          textStyle: const TextStyle(
            fontSize: 22,
          )
      ),
    );
  }

  static Widget GecisEkraniAppBarLeadingIcon(IconData icon){
    return Icon(
      icon,
    );
  }

  static Widget GirisEkraniOrtakButtonYazi(String yaziMetni){
    return Center(
      child: Text(
        yaziMetni,
        style: GoogleFonts.ubuntu(
          textStyle: const TextStyle(
            fontSize: 15.5,
          ),
        ),
      ),
    );
  }

  static Widget SifreYenilemeAlertDialogBaslik(String yaziMetni){
    return Center(
      child: Text(
        yaziMetni,
      ),
    );
  }

  static Widget SifreYenilemeButtonYazi(String yaziMetni){
    return Text(
      yaziMetni,
    );
  }

  static Widget SayfaVeriYokLoadingAnimasyon(var renk){
    return CircularProgressIndicator(
      color: renk,
    );
  }

  static Widget veriYokAnimasyonu(String lottieYolu){
    return Lottie.asset(
      lottieYolu,
      width: 200,
      height: 200,
    );
  }

  static Widget CardListBirinciYazi(String yaziMetni){
    return Text(
      yaziMetni,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget CardListIkinciYazi(String yaziMetni){
    return Text(
      yaziMetni,
      style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 16,
          )
      ),
    );
  }

  static Widget SayfaCardListUstuBaslik(String yaziMetni){
    return Text(
      yaziMetni,
      style: GoogleFonts.akayaKanadaka(
          textStyle: const TextStyle(
            fontSize: 20.5,
          )
      ),
    );
  }

  static Future<bool?> ToastKisaSureliMesajDondur(String yaziMetni){
    return Fluttertoast.showToast(
      msg: yaziMetni,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 16,
    );
  }

  static Future<bool?> ToastUzunSureliMesajDondur(String yaziMetni){
    return Fluttertoast.showToast(
      msg: yaziMetni,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 16,
    );
  }

  static Widget AtaturkUniversitesiLogo(double yukseklikGenislik){
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(140.0),
          boxShadow: [
            BoxShadow(
                color: Sabitler.shadowRenk,
                blurRadius: 12,
                spreadRadius: 2,
                blurStyle: BlurStyle.normal,
                offset: const Offset(0, 7)
            ),
          ]
      ),
      child: Image.asset(
        "resimler/Ataturkuni_logo.png",
        width: yukseklikGenislik,
        height: yukseklikGenislik,
      ),
    );
  }

  static Widget OrtakTextField(var controller,Color cursorColor,
      TextInputType textInputType,IconData prefixIcon,Color prefixIconColor,
      String hintText,String labelText){
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      textAlign: TextAlign.start,
      controller: controller,
      cursorColor: cursorColor,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 17,bottom: 17),
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Sabitler.txtRenk,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15.0),
        ),
        fillColor: Colors.grey[300],
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  static Widget SifreYenilemeTextFormField(var controller){
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Şifre Yenile",
        labelStyle: TextStyle(
          color: Colors.green,
        ),
        hintText: "Yeni Şifrenizi Giriniz",
        icon: Icon(
          Icons.password_rounded,
          color: Colors.green,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: controller,
    );
  }

  static BoxShadow OrtakTextFieldShadow(){
    return BoxShadow(
        color: Sabitler.shadowRenk,
        blurRadius: 13,
        offset: const Offset(0, 7)
    );
  }

  static BoxShadow OrtakProfilResimShadow(){
    return const BoxShadow(
      color: Colors.blueGrey,
      blurRadius: 10,
      offset: Offset(0, 7),
    );
  }

  static Widget kullanicilarOrtakEklemeGuncellemeTextFormField(String labelText,
      Color labelColor,String hintText,IconData icon,Color iconColor,TextInputType inputType,
      var controller,Color cursorColor){
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        hintText: hintText,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
      keyboardType: inputType,
      controller: controller,
      cursorColor: cursorColor,
    );
  }

}