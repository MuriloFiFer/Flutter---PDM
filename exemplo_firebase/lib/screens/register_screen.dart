import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _service = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Layout da tela de registro com formulário para registrar um novo usuário
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira um e-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (value) {},
                ),
                TextFormField(
                  controller: _confirmedPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                  validator: (value) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _registrarUser();
                  },
                  child: const Text('Registrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registrarUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmedPasswordController.text) {
        await _service.registerUsuario(
            _emailController.text, _confirmedPasswordController.text);
        // Navegação para página interna após o registro bem-sucedido
        Navigator.pushNamed(context, '/login');
      } else {
        // Mensagem de erro se as senhas não coincidirem
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('As senhas não conferem!'),
          ),
        );
        _passwordController.clear();
        _confirmedPasswordController.clear();
      }
    }
  }
}
