import 'package:app/data/datasources/cadastro_funcionario_datasource.dart';
import 'package:app/index.dart';

class CadastroFuncionarioRepository {
  final CadastroFuncionarioDatasource _api = CadastroFuncionarioDatasource();

  Future cadastrarFuncionarioRepo(FuncionarioModel funcionario) async {
    await _api.cadastrarFuncionario(funcionario).then((value) {
      try {
        if (value['statusCode'] == 200) {
          return;
        } else {
          Dialogs.close();
          Dialogs.showAlertDialog(value['erro'], 'Atenção!');
        }
      } catch (e) {
        Dialogs.close();
        Dialogs.showAlertDialog(e.toString(), 'Atenção!');
      }
    });
  }
}
