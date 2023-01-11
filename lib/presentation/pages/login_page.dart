import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _enableSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/d_ferias_logo.png'),
              const SizedBox(height: 17.0),
              const Text(
                'Bem-vindo(a)!',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              _loginForm(),
              const SizedBox(height: 25.0),
              _loginButton(),
              const SizedBox(height: 25.0),
              _resetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      child: Column(
        children: [
          _emailField(),
          const SizedBox(height: 15.0),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        label: const Text('E-mail'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        prefixIcon: const Icon(
          Icons.person_outline_rounded,
          color: Colors.orange,
          size: 30.0,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.text,
      obscureText: !_enableSenha,
      decoration: InputDecoration(
        label: const Text('Senha'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.orange,
          size: 25.0,
        ),
        suffixIcon: GestureDetector(
          child: !_enableSenha ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          onTap: () {
            _visualizarSenha();
          },
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(50.0)),
        child: const Text(
          'Entrar',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _resetPasswordButton() {
    return OutlinedButton(
      child: const Text(
        'Esqueceu sua senha?',
        style: TextStyle(fontSize: 17.0),
      ),
      onPressed: () {},
    );
  }

  void _visualizarSenha() {
    if (_enableSenha == false) {
      setState(() {
        _enableSenha = true;
      });
    } else {
      setState(() {
        _enableSenha = false;
      });
    }
  }
}
