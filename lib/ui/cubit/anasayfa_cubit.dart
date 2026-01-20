import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/yapilacaklar.dart';
import 'package:to_do_app/data/repo/yapilacaklar_dao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yapilacaklar>>{
  AnasayfaCubit():super(<Yapilacaklar>[]);

  var yrepo = YapilacaklarDaoRepository();

  Future<void> yapilacaklariYukle() async{
    var liste = await yrepo.yapilacaklariYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await yrepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int yapilacak_id) async{
    await yrepo.sil(yapilacak_id);
    await yapilacaklariYukle();
  }
}