import 'package:dinamik_ortalama/constants/app_constants.dart';
import 'package:dinamik_ortalama/helper/data_helper.dart';
import 'package:dinamik_ortalama/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildi; //B
  DersListesi({required this.onElemanCikarildi, Key? key}) : super(key: key);
  List<Ders> tumDersler = DataHelper.tumEklenenDersler;
  @override
  Widget build(BuildContext context) {
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: DataHelper.tumEklenenDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                //sağa kaydırınca silme olayı için Card ı içine aldık.
                key: UniqueKey(), //her elemana farklı değerler atıyor
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  onElemanCikarildi(index); 
                },
                child: Card(
                  child: ListTile(
                    title: Text(DataHelper.tumEklenenDersler[index].ad),
                    leading: CircleAvatar(
                      backgroundColor: Sabitler.anaRenk,
                      child: Text((tumDersler[index].harfDegeri).toString()),
                    ),
                    subtitle: Text(
                        '${tumDersler[index].krediDegeri} Kredi, Not Değeri: ${tumDersler[index].harfDegeri}'),
                  ),
                ),
              );
            }) : Container(  //burada if in else yapısı başlıyor.  
            child: Center(
              child: Text(
                'Ders Ekleyiniz',
                style: Sabitler.baslikStyle,
              ),
            ),
          );
  }
}
