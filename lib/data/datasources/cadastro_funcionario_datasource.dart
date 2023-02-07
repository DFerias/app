import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

class CadastroFuncionarioDatasource {
  static final CadastroFuncionarioDatasource instance = CadastroFuncionarioDatasource();

  Future cadastrarFuncionario(FuncionarioModel funcionario) async {
    try {
      final response = await http.post(
        Uri.parse('$urlApi/api/user/new'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: funcionario.toJson(),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 403) {
          throw const Failure(erroAutorizacao);
        } else {
          throw const Failure(erroRequisicao);
        }
      }

      return FuncionarioModel.fromJson(response.body);
    } catch (e) {
      throw HttpError('$e');
    }
  }
}
