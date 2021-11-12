import 'package:dinamik_ortalama/widgets/ortalama_hesapla_page.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dinamik Ortalama Hesapla',
      theme: ThemeData(
        primarySwatch: Sabitler.anaRenk,
        visualDensity: VisualDensity.adaptivePlatformDensity, //diğer platformlara uygun çalışmasını sağlıyormuş
      ),
      home: OrtalamaHesaplaPage(),
    );
  }
}
