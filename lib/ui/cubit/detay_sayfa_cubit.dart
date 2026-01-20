import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repo/yapilacaklar_dao_repository.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit():super(0);

  var yrepo = YapilacaklarDaoRepository();

  Future<void> guncelle(int yapilacak_id, String yapilacak_baslik, String yapilacak_aciklama) async{
    await yrepo.guncelle(yapilacak_id, yapilacak_baslik, yapilacak_aciklama);
  }

}