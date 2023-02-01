import 'package:app/index.dart';

class ListarFeriasRepository {
  final ListarFeriasDatasource _api = ListarFeriasDatasource();
  List<SolicitacaoFeriasModel>? listaGeral;

  Future listarFeriasGeralRepo() async {
    await _api.listarFeriasGeral().then((value) {
      try {
        if (value['statusCode'] == 200) {
          listaGeral = List<SolicitacaoFeriasModel>.from(value['data'].map((i) => SolicitacaoFeriasModel.fromJson(i)));
        }
      } catch (e) {
        Dialogs.showAlertDialog(e.toString(), 'Atenção!');
      }
    });

    return listaGeral;
  }
}
