import 'dart:convert';

import 'package:app/index.dart';

class AuthService {
  static final _cache = App.cache;
  static final AuthService instance = _cache!.containsKey('token') ? AuthService.fromCache() : AuthService();

  String? token;
  Funcionario? usuario;
  bool? isLider;
  bool? authRh = false;

  AuthService({
    this.token,
    this.usuario,
    this.isLider,
    this.authRh,
  });

  Funcionario get user => usuario ?? FuncionarioModel.fromCache();

  bool get logado {
    return token != null;
  }

  void atualizarSessao({String? token, Funcionario? usuario, bool? isLider, bool? authRh}) {
    if (token != null) {
      this.token = token;
    }

    if (usuario != null) {
      this.usuario = usuario;
    }

    if (isLider != null) {
      this.isLider = isLider;
    }

    if (authRh != null) {
      this.authRh = authRh;
    }

    gravarCache();
  }

  factory AuthService.fromCache() {
    return AuthService(
      token: _cache!.getString('token'),
      usuario: FuncionarioModel.fromCache(),
      isLider: _cache!.getBool('lider'),
      authRh: _cache!.getBool('auth_rh'),
    );
  }

  void logOut() {
    token = null;
    usuario = null;
    authRh = null;
    isLider = null;

    _cache!.clear();
  }

  gravarCache() {
    if (token != null) {
      _cache!.setString('token', token!);
    }

    if (usuario != null) {
      _cache?.setString('usuario', json.encode(FuncionarioModel.toCache(usuario!)));
    }

    if (isLider != null) {
      _cache?.setBool('lider', isLider!);
    }

    if (authRh != null) {
      _cache?.setBool('auth_rh', authRh!);
    }
  }
}
