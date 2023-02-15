import 'dart:convert';
import 'package:app/index.dart';

class AuthService {
  static final _cache = App.cache;
  static final AuthService instance = _cache!.containsKey('token') ? AuthService.fromCache() : AuthService();

  String? token;
  Funcionario? usuario;

  AuthService({
    this.token,
    this.usuario,
  });

  bool get logado {
    return token != null;
  }

  void atualizarSessao({String? token, Funcionario? usuario}) {
    if (token != null) {
      this.token = token;
    }

    if (usuario != null) {
      this.usuario = usuario;
    }

    gravarCache();
  }

  factory AuthService.fromCache() {
    return AuthService(
      token: _cache!.getString('token'),
      usuario: FuncionarioModel.fromCache(),
    );
  }

  void logOut() {
    token = null;
    usuario = null;
    _cache!.clear();
  }

  gravarCache() {
    if (token != null) {
      _cache!.setString('token', token!);
    }

    if (usuario != null) {
      _cache?.setString('usuario', json.encode(usuario));
    }
  }
}
