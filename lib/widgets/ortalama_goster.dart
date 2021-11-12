import 'package:dinamik_ortalama/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OrtalamaGoster extends StatelessWidget {
  //sadece gelen veriyi göstereceğinden stateless yaptı.
  final double ortalama;
  final int dersSayisi;
  const OrtalamaGoster(
      {required this.dersSayisi, required this.ortalama, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, //yukardan aşağı
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dersSayisi > 0 ? '$dersSayisi Ders Girildi' : 'Ders Seçiniz',
          style: Sabitler.dersSayisiStyle,
        ), //if else yapısı koyucaz
        Text(
          ortalama >= 0 ? '${ortalama.toStringAsFixed(2)}' : '0.0',
          //virgülden sonra 2 hane geçmesin diye süslü parantez içi işlem yapıldı
          style: Sabitler.ortalamaStyle,
        ),
        Text(
          'Ortalama',
          style: Sabitler.dersSayisiStyle,
        ),
      ],
    );
  }
}
