import 'package:app/data/datasources/listar_ferias_datasource.dart';
import 'package:app/data/models/lista_ferias_geral_model.dart';
import 'package:app/index.dart';

class ListarFeriasRepository {
  final ListarFeriasDatasource _api = ListarFeriasDatasource();
  List<SolicitacaoFeriasGeralModel>? listaGeral;

  Future listarFeriasGeralRepo() async {
    await _api.listarFeriasGeral().then((value) {
      try {
        if (value['statusCode'] == 200) {
          listaGeral = List<SolicitacaoFeriasGeralModel>.from(value['data'].map((i) => SolicitacaoFeriasGeralModel.fromJson(i)));
        }
      } catch (e) {
        Dialogs.showAlertDialog(e.toString(), 'Atenção!');
      }
    });

    return listaGeral;
  }
}
