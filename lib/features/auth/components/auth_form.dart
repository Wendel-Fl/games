import 'package:flutter/material.dart';
import 'package:games/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../controller/auth_controller.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final Map<String, String> _authData = {'email': '', 'senha': ''};
  late final AuthController controller;

  bool _isObscured = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
    controller = context.read<AuthController>();

    controller.addListener(() {
      if (controller.state == AuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Row(
              children: [
                Icon(
                  Icons.error_outline_outlined,
                  color: Colors.white,
                ),
                Text(' Erro na Autenticação'),
              ],
            ),
          ),
        );
      } else if (controller.state == AuthState.success) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocus.dispose();
  }

  Future<void> submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    AuthController auth = Provider.of(context, listen: false);
    await auth.login(_authData['email']!, _authData['senha']!);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 330,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                      fontSize: 18,
                  fontWeight: FontWeight.normal
                ),
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Informe seu e-mail...',
                  border: OutlineInputBorder(),
                ),
                onSaved: (email) => _authData['email'] = email ?? '',
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(
                  _passwordFocus,
                ),
                validator: (email) {
                  final newEmail = email ?? '';
                  if (newEmail.trim().isEmpty || !newEmail.contains('@')) {
                    return 'Informe um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _isObscured,
                focusNode: _passwordFocus,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                ),
                decoration: InputDecoration(
                  label: const Text('Senha'),
                  hintText: 'Informe sua senha...',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: _isObscured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                onFieldSubmitted: (_) => submit(),
                onSaved: (senha) => _authData['senha'] = senha ?? '',
                validator: (senha) {
                  final newSenha = senha ?? '';
                  if (newSenha.isEmpty || newSenha.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.state == AuthState.loading
                    ? null
                    : () {
                        submit();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25.0)),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
