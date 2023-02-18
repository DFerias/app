import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, AuthController> {
  bool _enableSenha = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthController, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => Navigator.pushNamed(context, '/home'),
          );
        }
        if (state.status == AuthStatus.loading) {
          Dialogs.showLoadingDialog();
        }
        if (state.status == AuthStatus.error) {
          Dialogs.close();
          Dialogs.showAlertDialog(state.errorMessage, 'Atenção!');
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
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
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldWidget(
            controllerField: _email,
            keyBoardType: TextInputType.emailAddress,
            label: 'E-mail',
            textInputAction: TextInputAction.next,
            prefixIcon: Icons.person_outline_rounded,
            validator: Validatorless.required('E-mail Obrigatória *'),
          ),
          const SizedBox(height: 15.0),
          TextFieldWidget(
            controllerField: _password,
            keyBoardType: TextInputType.text,
            label: 'Senha',
            obscureText: !_enableSenha,
            textInputAction: TextInputAction.send,
            prefixIcon: Icons.lock_outline,
            suffixIcon: GestureDetector(
              child: !_enableSenha ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
              onTap: () {
                _visualizarSenha();
              },
            ),
            validator: Validatorless.required('Senha Obrigatória *'),
          ),
        ],
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
          if (_formKey.currentState?.validate() ?? false) {
            controller.auth(_email.text, _password.text);
            // _authBloc.add(LoginEvent(email: _email.text, password: _password.text));
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
