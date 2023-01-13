import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthBloc _authBloc;
  bool _enableSenha = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthSucess) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => Navigator.pushNamed(context, '/home'),
          );
        }
        if (state is AuthLoading) {
          Dialogs.showLoadingDialog();
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/d_ferias_logo.png'),
                const SizedBox(height: 17.0),
                Text(
                  'Bem-vindo(a)!',
                  style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
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
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
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
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
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
      controller: _password,
      keyboardType: TextInputType.text,
      obscureText: !_enableSenha,
      style: TextStyle(color: Colors.grey[700]),
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
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _authBloc.add(LoginEvent(email: _email.text, password: _password.text));
          }
        },
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
