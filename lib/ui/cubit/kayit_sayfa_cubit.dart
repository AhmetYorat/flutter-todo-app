import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repo/yapilacaklar_dao_repository.dart';

class KayitSayfaCubit extends Cubit<void>{
  KayitSayfaCubit():super(0);

  var yrepo = YapilacaklarDaoRepository();

  Future<void> ekle(String yapilacak_baslik, String yapilacak_aciklama) async {
    await yrepo.ekle(yapilacak_baslik, yapilacak_aciklama);
  }
}