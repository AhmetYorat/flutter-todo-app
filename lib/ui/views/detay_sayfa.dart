import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/yapilacaklar.dart';
import 'package:to_do_app/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Yapilacaklar yapilacak;
  DetaySayfa({required this.yapilacak});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfBaslik = TextEditingController();
  var tfAciklama = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var yapilacak = widget.yapilacak;
    tfBaslik.text = yapilacak.yapilacak_baslik;
    tfAciklama.text = yapilacak.yapilacak_aciklama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.yapilacak.yapilacak_baslik),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfBaslik, decoration: const InputDecoration(hintText: "Başlık"),),
              TextField(controller: tfAciklama, decoration: const InputDecoration(hintText: "Açıklama"),),
              ElevatedButton(
                  onPressed: (){
                    context.read<DetaySayfaCubit>().guncelle(widget.yapilacak.yapilacak_id, tfBaslik.text, tfAciklama.text);
                    Navigator.pop(context);
                  }, child: Text("Güncelle")),
            ],
          ),
        ),
      ),
    );
  }
}
