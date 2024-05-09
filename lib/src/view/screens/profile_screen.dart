import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/models/user.dart';
import 'package:challengify_app/src/utils/jwt_decoder.dart';
import 'package:challengify_app/src/view/screens/login_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/web_interactors/user_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserInteractor userInteractor =
      UserInteractor(baseUrl: dotenv.env['BASEURL']!);

  late Future<User?> _userFuture = getUser();

  Future<User?> getUser() async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null || jwt.isEmpty) {
      return null; // Indicate no user to display
    } else {
      String idString = JwtDecoder.decode(jwt)['sub'];
      int id = int.parse(idString);
      return userInteractor.getUser(id);
    }
  }

  @override
  void initState() {
    super.initState();
    _userFuture = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: FullWidhtButton(
              onPressed: () => {
                _goToLoginPage(context).then((value) => setState(() {
                      _userFuture = getUser();
                    }))
              },
              text: 'Go to Login Page',
            ),
          );
        } else {
          User user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Name: ${user.name}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Email: ${user.email}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                // print year, month, day,
                Text(
                    'Created at: ${user.createdAt.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 20)),

                FullWidhtButton(
                    onPressed: () async =>
                        {await Storage.removeJwt(), _goToLoginPage(context)},
                    text: "Log out")
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> _goToLoginPage(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    ).then((value) => setState(() {
          _userFuture = getUser();
        }));
  }
}
