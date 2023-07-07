import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/auth.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    /*
  email: 'candidato@tabulero.com.br',
  senha: '123456'
  */
    'email': '',
    'password': ''
  };

  bool _isLoading = false;
  bool _isObscured = false;

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    await auth.login(_authData['email']!, _authData['password']!);
    /*try {
    } catch (error) {
      print('Erro');
    }*/

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _isObscured = true;
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
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('E-mail'),
              TextFormField(
                decoration: const InputDecoration(
                  label: Center(child: Text('Informe seu e-mail...')),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (email) {
                  final newEmail = email ?? '';
                  if (newEmail.trim().isEmpty || !newEmail.contains('@')) {
                    return 'Informe um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Senha'),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: _isObscured,
                controller: _passwordController,
                decoration: InputDecoration(
                  label: const Center(child: Text('Informe sua senha...')),
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
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (password) {
                  final newPassword = password ?? '';
                  if (newPassword.isEmpty || newPassword.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)),
                child: const Text('Entrar'),
              )
            ],
          ),
        ),
      ),
      // key: _formKey,
    );
  }
}
