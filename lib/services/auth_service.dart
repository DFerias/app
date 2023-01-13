import 'package:app/index.dart';

class AuthService {
  static final _cache = App.cache;
  static final AuthService instance = _cache!.containsKey('token') ? AuthService.fromCache() : AuthService();

  String? token;

  AuthService({
    this.token,
  });

  bool get logado {
    return token != null;
  }

  void atualizarSessao({String? token}) {
    if (token != null) {
      this.token = token;
    }

    gravarCache();
  }

  factory AuthService.fromCache() {
    return AuthService(
      token: _cache!.getString('token'),
    );
  }

  void logOut() {
    token = null;
    _cache!.clear();
  }

  gravarCache() {
    if (token != null) {
      _cache!.setString('token', token!);
    }
  }
}
