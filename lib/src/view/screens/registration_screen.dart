import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/view/widgets/text_input.dart';
import 'package:challengify_app/src/web_interactors/auth_interactor.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _authInteractor = AuthInteractor(baseUrl: 'http://10.0.2.2:8080');

  String _errorMessage = '';

  Future<void> _register() async {
    try {
      final jwt = await _authInteractor.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
        _passwordConfirmationController.text,
      );
      await Storage.saveJwt(jwt);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Registration failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextInputWidget(
                controller: _usernameController,
                labelText: 'Username',
              ),
              TextInputWidget(
                controller: _emailController,
                labelText: 'Email',
              ),
              TextInputWidget(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              TextInputWidget(
                controller: _passwordConfirmationController,
                labelText: 'Password confirmation',
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
              Text(_errorMessage),
            ],
          ),
        ),
      ),
    );
  }
}
