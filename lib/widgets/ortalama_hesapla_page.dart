import 'package:dinamik_ortalama/constants/app_constants.dart';
import 'package:dinamik_ortalama/helper/data_helper.dart';
import 'package:dinamik_ortalama/model/ders.dart';
import 'package:dinamik_ortalama/widgets/ders_listesi.dart';
import 'package:dinamik_ortalama/widgets/kredi_dropdown_widget.dart';
import 'package:dinamik_ortalama/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  _OrtalamaHesaplaPageState createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  //bunu dropdownın içinden buraya taşıdık. buildcontext in içinde olmaması gerekiyor. tetiklenince bu sabiti kullanıyor.
  var formKey = GlobalKey<FormState>();
  //Form için key oluşturduk. diğer widgetlardan da erişmek için değere.
  double secilenHarfDegeri = 4.0;
  double secilenKrediDegeri = 1.0;
  String girilenDersAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //ekranı yana çevirince veren sığmama hatası iptali
      appBar: AppBar(
        backgroundColor: Colors.transparent, //renksiz yaptık
        elevation: 0, //bu olmadığı zaman yine de bir appbar çıkıyor.
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      child: _buildForm(),
                    )),
                Expanded(
                  flex: 1, //default değer de 1'di.
                  child: OrtalamaGoster(
                      dersSayisi: DataHelper.tumEklenenDersler.length,
                      ortalama: DataHelper.ortamalaHesapla()),
                )
              ],
            ),
            Expanded(
              child: DersListesi(
                onElemanCikarildi: (index) {
                  DataHelper.tumEklenenDersler.removeAt(
                      index); //aşağıdakn yukarıya değişiklik gönderiyoruz
                  print('Eleman çikarildi $index');
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key:
          formKey, //hala aynı sınıfta olduğumuzdan kullanabiliriz. sarı parantez.
      child: Column(
        children: [
          _buildTextFormField(),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, //yanyana olan cisimleri dağıttı güzelce.
            children: [
              _buildHarfler(),
              // _buildKrediler(), bunu widget ve callback ile yapıp tüm sayfanın refresh olmasını engelliyoruz
              KrediDropDownWidget(
                onKrediSecildi: (kredi) {
                  secilenKrediDegeri =
                      kredi; //diğer kredi dropdown widget'dan buraya değer göndermiş olduk.
                },
              ),
              IconButton(
                  onPressed: _dersEkleveOrtalamaHesapla,
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Sabitler.anaRenk,
                    size: 30,
                  )),
            ],
          )
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return 'Ders adını giriniz!';
        } else {
          return null;
        }
      }, //girilen değeri kontrol eder.
      decoration: InputDecoration(
        hintText: 'Ders Adı',
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none, //dış çerceveyi sildi
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _buildHarfler() {
    //dropdownları düzenlemek için container içine almak gerekiyor.

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('Ders Notu:'),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16), //içi
          margin: EdgeInsets.symmetric(vertical: 10), //dışı
          decoration: BoxDecoration(
            color: Sabitler.anaRenk.shade100.withOpacity(0.3),
            borderRadius: Sabitler.borderRadius,
          ),
          child: DropdownButton<double>(
            value: secilenHarfDegeri,
            onChanged: (deger) {
              setState(() {
                secilenHarfDegeri =
                    deger!; //null değer olamayacağını vurguladık
              });
            },
            items: DataHelper.tumDerslerinHarfleri(),
            underline: Container(), //dropdown altındaki boş çizgiyi yok ettik.
          ),
        ),
      ],
    );
  }

/*  //burayı artık kullanmıyoruz. farklı bir widgetla callback yaptık.  
  _buildKrediler() {
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
                secilenKrediDegeri =
                    deger!; //null değer olamayacağını vurguladık
              });
            },
            items: DataHelper.tumDerslerinKredileri(),
            underline: Container(), //dropdown altındaki boş çizgiyi yok ettik.
          ),
        ),
      ],
    );
  }
*/
  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri); //Ders sınıfı oluşturmuştuk ModelDE.
      DataHelper.dersEkle(eklenecekDers);
      //print(DataHelper.ortamalaHesapla());
      setState(() {}); //buildcontext i çalıştırır tekrardan
    }
  }
}
