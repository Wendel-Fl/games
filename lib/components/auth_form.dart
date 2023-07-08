import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/auth.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // final _emailController = TextEditingController();
  // final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'email': '',
    'senha': ''
  };

  bool _isObscured = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  /*Future<void> submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);
    await auth.login(_authData['email']!, _authData['senha']!);
    // try {
    // } catch (error) {
    //   print('Erro');
    // }

    setState(() => _isLoading = false);
  }*/

  Future<void> submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    await auth.login(_authData['email']!, _authData['senha']!);
    // try {
    // } catch (error) {
    //   print('Erro');
    // }

    // var url = Uri.parse('http://206.189.206.44:8080/login');
    // var response = await http.post(
    //   url,
    //   body: jsonEncode(_authData),
    //   headers: {'Content-Type': 'application/json'},
    // );

    setState(() => _isLoading = false);

    // print(response.statusCode);
    // print(response.body);
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
              TextFormField(
                // controller: _emailController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                  hintText: 'Informe seu e-mail...',
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
              TextFormField(
                // controller: _senhaController,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  label: const Text('Senha'),
                  hintText: 'Informe sua senha...',
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
                onPressed: () {
                  submit();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)),
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
