import 'package:dinamik_ortalama/model/ders.dart';
import 'package:flutter/material.dart';

class DataHelper {
  static List<Ders> tumEklenenDersler =
      []; //içinde Ders Class ları olan bir liste

  static dersEkle(Ders ders) {
    tumEklenenDersler.add(ders);
  }

  static double ortamalaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    tumEklenenDersler.forEach((element) {
      toplamNot = toplamNot + (element.krediDegeri * element.harfDegeri);
      toplamKredi = toplamKredi + element.krediDegeri;
    });
    return toplamNot / toplamKredi;  //genel ortalamayı verir
  }

  static List<String> _tumDerslerinHarfleri() {
    return [
      'AA',
      'BA',
      'BB',
      'CB',
      'CC',
      'DC',
      'DD',
      'FD',
      'FF',
    ];
  }

  static double _harfiNotaCevir(String harf) {
    switch (harf) {
      case 'AA':
        return 4.0;
      case 'BA':
        return 3.5;
      case 'BB':
        return 3.0;
      case 'CB':
        return 2.5;
      case 'CC':
        return 2.0;
      case 'DC':
        return 1.5;
      case 'DD':
        return 1.0;
      case 'FD':
        return 0.5;
      case 'FF':
        return 0;
      default:
        return 1;
    }
  }

  static List<DropdownMenuItem<double>> tumDerslerinHarfleri() {
    return _tumDerslerinHarfleri()
        .map(
          //.map iterasyon yapıyor.
          (e) => DropdownMenuItem(
            // e içerik olarak  'AA'  gibi değerler alıyor sırayla
            child: Text(e),
            value: _harfiNotaCevir(e),
          ),
        )
        .toList(); //en son yapıyı tumdersinharlerinde bir listeye dönüştürdü
  }

  static List<int> _tumKrediler() {
    return List.generate(10, (index) => index + 1)
        .toList(); //1 'den 10 a rakamlar olan liste yaptık
  }

  static List<DropdownMenuItem<double>> tumDerslerinKredileri() {
    return _tumKrediler()
        .map(
          (e) => DropdownMenuItem(
              //_tumKrediler listesindeki  elemanlar = e  ve int türünde olduğundan veri dönüşümleri çok önemli burada.
              child: Text(e.toString()), //Text'in içinde  string kullanılır.
              value: e.toDouble()),
        )
        .toList();
  }
}
