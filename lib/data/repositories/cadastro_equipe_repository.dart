import 'package:app/data/datasources/cadastro_equipe_datasource.dart';
import 'package:app/data/models/equipe_model.dart';
import 'package:app/index.dart';

class CadastroEquipeRepository {
  final CadastroEquipeDatasource _api = CadastroEquipeDatasource();
  EquipeModel? dados;

  Future cadastroEquipeRepo(String? id, String nome, String cor) async {
    int? idLider = id != null && id.isNotEmpty ? int.parse(id) : null;

    String corEquipe = cor.replaceAll('Color(0xff', '#').replaceAll(')', '');

    await _api.cadastroEquipe(idLider, nome, corEquipe).then((value) {
      try {
        if (value['statusCode'] == 201) {
          dados = EquipeModel.fromJson(value['data']);
          Dialogs.close();
        } else {
          Dialogs.close();
        }
      } catch (e) {
        Dialogs.close();
        Dialogs.showAlertDialog(e.toString(), 'Atenção!');
      }
    });

    return dados;
  }
}
