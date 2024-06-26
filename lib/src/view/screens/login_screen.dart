import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/view/screens/registration_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/view/widgets/text_input.dart';
import 'package:challengify_app/src/web_interactors/auth_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authInteractor = AuthInteractor(baseUrl: dotenv.env['BASEURL']!);

  String _errorMessage = '';

  Future<void> _login() async {
    try {
      final jwt = await _authInteractor.login(
        _emailController.text,
        _passwordController.text,
      );
      await Storage.saveJwt(jwt);
      setState(() {
        _errorMessage = '';
      });

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed: $e';
      });
    }
  }

  _visibilityBasedOnError() {
    if (_errorMessage.isNotEmpty) {
      return Text(
        _errorMessage,
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return const SizedBox
          .shrink(); // Returns an empty box when _errorMessage is empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextInputWidget(
                controller: _emailController,
                labelText: 'Email',
              ),
              TextInputWidget(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              FullWidhtButton(
                onPressed: _login,
                text: "Login",
              ),
              _visibilityBasedOnError(),
              FullWidhtButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                text: "Register",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
