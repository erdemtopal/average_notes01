import 'package:dinamik_ortalama/constants/app_constants.dart';
import 'package:dinamik_ortalama/helper/data_helper.dart';
import 'package:flutter/material.dart';

class KrediDropDownWidget extends StatefulWidget {
  final Function onKrediSecildi;
  KrediDropDownWidget({required this.onKrediSecildi, Key? key})
      : super(key: key);

  @override
  _KrediDropDownWidgetState createState() => _KrediDropDownWidgetState();
}

class _KrediDropDownWidgetState extends State<KrediDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    double secilenKrediDegeri = 1.0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('Ders Kredisi:'),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16), //içi
          margin: EdgeInsets.symmetric(vertical: 10), //dışı
          decoration: BoxDecoration(
            color: Sabitler.anaRenk.shade100.withOpacity(0.3),
            borderRadius: Sabitler.borderRadius,
          ),
          child: DropdownButton<double>(
            value: secilenKrediDegeri,
            onChanged: (deger) {
              setState(() {
                secilenKrediDegeri =deger!; 
                    //null değer olamayacağını vurguladık
                widget.onKrediSecildi(deger);
                //widgetı seçtik çünkü üst kısımda tanımlanmış. degeri üst widgeta callvback ile göndermiş olduk
              });
            },
            items: DataHelper.tumDerslerinKredileri(),
            underline: Container(), //dropdown altındaki boş çizgiyi yok ettik.
          ),
        ),
      ],
    );
  }
}
