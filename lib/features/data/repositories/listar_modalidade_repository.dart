import 'package:app/index.dart';

class ListarModalidadeRepository {
  final ListarModalidadesDatasource _api = ListarModalidadesDatasource();

  List<ModalidadeModel>? _listModalidade = [];

  Future listarModalidadeRepo() async {
    await _api.listarModalidade().then((value) {
      try {
        if (value['statusCode'] == 200) {
          // Dialogs.close();
          _listModalidade = List<ModalidadeModel>.from(value['data'].map((i) => ModalidadeModel.fromJson(i)));
        } else {
          // Dialogs.close();
        }
      } catch (e) {
        // Dialogs.close();
      }
    });

    return _listModalidade;
  }
}
