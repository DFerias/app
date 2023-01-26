import 'package:app/index.dart';
import 'package:intl/intl.dart';

class SolicitacaoFeriasRepository {
  final SolicitacaoFeriasDatasource _api = SolicitacaoFeriasDatasource();
  SolicitacaoFeriasModel? dados;

  Future solicitacaoFeriasRepo(DateTime? inicio, DateTime? fim) async {
    String? dataInicial = DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(inicio.toString()));
    String? dataFinal = DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(fim.toString()));

    await _api.enviarSolicitacao(dataInicial, dataFinal).then((value) {
      try {
        if (value['statusCode'] == 201) {
          dados = SolicitacaoFeriasModel.fromJson(value['data']);
          Dialogs.close();
        } else {
          Dialogs.close();
          Dialogs.showAlertDialog(value['erro'], 'Atenção!');
        }
      } catch (e) {
        Dialogs.close();
        Dialogs.showAlertDialog(e.toString(), 'Atenção!');
      }
    });

    return dados;
  }
}
