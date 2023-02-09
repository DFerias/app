import 'package:app/index.dart';

class AuthRepository {
  AuthRemoteDatasource auth = AuthRemoteDatasource();
  AuthModel? dados;

  Future<dynamic> login(String email, String password) async {
    await auth.login(email, password).then((value) {
      try {
        if (value['statusCode'] == 200) {
          dados = AuthModel.fromJson(value['data']);
        }
      } catch (e) {
        Dialogs.close();
        Dialogs.showAlertDialog(e.toString(), 'Atenção!');
      }
    });

    return dados;
  }
}
