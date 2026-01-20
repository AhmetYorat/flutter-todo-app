import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/yapilacaklar.dart';
import 'package:to_do_app/ui/cubit/anasayfa_cubit.dart';
import 'package:to_do_app/ui/views/detay_sayfa.dart';
import 'package:to_do_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu = false;

  Future<void> sil(int yapilacak_id) async{
    print("Sil: ${yapilacak_id}");
  }

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yapilacaklariYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(
          decoration: InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            context.read<AnasayfaCubit>().ara(aramaSonucu);
          },
        ) :
        const Text("Yapılacaklar"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(
              onPressed: (){
                setState(() {
                  aramaYapiliyorMu = false;
                });
              }, icon: Icon(Icons.close)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yapilacaklar>>(
          builder: (context, yapilacaklarListesi){
            if(yapilacaklarListesi.isNotEmpty){
              return ListView.builder(
                itemCount: yapilacaklarListesi.length,
                itemBuilder: (context, indeks){
                  var yapilacak = yapilacaklarListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yapilacak: yapilacak)))
                      .then((value){
                          context.read<AnasayfaCubit>().yapilacaklariYukle();
                      });
                    },
                    child: Card(
                      child: SizedBox( height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(yapilacak.yapilacak_baslik, style: TextStyle(fontSize: 20),),
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${yapilacak.yapilacak_baslik} yapıldı mı?"),
                                  action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: (){
                                        context.read<AnasayfaCubit>().sil(yapilacak.yapilacak_id);
                                      }),
                                ),
                              );
                            }, icon: Icon(Icons.check))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return const Center();
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => KayitSayfa()))
            .then((value){
              context.read<AnasayfaCubit>().yapilacaklariYukle();
            });
          },
          child: const Icon(Icons.add),
      ),
    );
  }
}
