import 'package:to_do_app/data/entity/yapilacaklar.dart';
import 'package:to_do_app/data/sqlite/veritabani_yardimcisi.dart';

class YapilacaklarDaoRepository {

  Future<List<Yapilacaklar>> yapilacaklariYukle() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM yapilacaklar");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Yapilacaklar(
          yapilacak_id: satir["yapilacak_id"],
          yapilacak_baslik: satir["yapilacak_baslik"],
          yapilacak_aciklama: satir["yapilacak_aciklama"]);
    });
  }

  Future<List<Yapilacaklar>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM yapilacaklar WHERE yapilacak_baslik like '%$aramaKelimesi%' ");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Yapilacaklar(
          yapilacak_id: satir["yapilacak_id"],
          yapilacak_baslik: satir["yapilacak_baslik"],
          yapilacak_aciklama: satir["yapilacak_aciklama"]);
    });
  }

  Future<void> guncelle(int yapilacak_id, String yapilacak_baslik, String yapilacak_aciklama) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenen = Map<String, dynamic>();
    guncellenen["yapilacak_baslik"] = yapilacak_baslik;
    guncellenen["yapilacak_aciklama"] = yapilacak_aciklama;
    await db.update("yapilacaklar", guncellenen, where: "yapilacak_id = ?", whereArgs: [yapilacak_id]);
  }

  Future<void> ekle(String yapilacak_baslik, String yapilacak_aciklama) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeni = Map<String, dynamic>();
    yeni["yapilacak_baslik"] = yapilacak_baslik;
    yeni["yapilacak_aciklama"] = yapilacak_aciklama;
    await db.insert("yapilacaklar", yeni);
  }

  Future<void> sil(int yapilacak_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("yapilacaklar", where: "yapilacak_id = ?", whereArgs: [yapilacak_id]);
  }
}