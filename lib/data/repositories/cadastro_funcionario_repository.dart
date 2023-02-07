import 'package:app/core/errors/failure.dart';
import 'package:app/data/datasources/cadastro_funcionario_datasource.dart';
import 'package:app/index.dart';

class CadastroFuncionarioRepository {
  final CadastroFuncionarioDatasource _api = CadastroFuncionarioDatasource();
  dynamic result;

  Future cadastrarFuncionarioRepo(FuncionarioModel funcionario) async {
    try {
      await _api.cadastrarFuncionario(funcionario).then((value) {
        /* if (value['statusCode'] == 200) {
          result = ;
        } else if (value['statusCode'] == 500) {
          result = value['erro'];
        } else {
          result = value['erro'];
        } */

        result = value;
      });

      return result;
    } on Failure catch (e) {
      var teste = e.message;
      return teste;
    }
  }
}
