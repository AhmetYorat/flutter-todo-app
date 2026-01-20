import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfBaslik = TextEditingController();
  var tfAciklama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Ekle"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfBaslik, decoration: InputDecoration(hintText: "Başlık"),),
              TextField(controller: tfAciklama, decoration: InputDecoration(hintText: "Açıklama"),),
              ElevatedButton(
                  onPressed: (){
                    context.read<KayitSayfaCubit>().ekle(tfBaslik.text, tfAciklama.text);
                    Navigator.pop(context);
                  }, child: Text("Ekle")),
            ],
          ),
        ),
      ),
    );
  }
}
