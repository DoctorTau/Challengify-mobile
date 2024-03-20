import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/models/user.dart';
import 'package:challengify_app/src/utils/jwt_decoder.dart';
import 'package:challengify_app/src/view/screens/login_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/web_interactors/user_interactor.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserInteractor userInteractor =
      UserInteractor(baseUrl: 'http://10.0.2.2:8080');

  Future<User?> getUser() async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null || jwt.isEmpty) {
      return null; // Indicate no user to display
    } else {
      String idString = JwtDecoder.decode(jwt)['sub'];
      int id = int.parse(idString);
      print('User ID: $id');
      return await userInteractor.getUser(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<User?>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            // log error

            return Center(
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                child: Text('Go to Login Page'),
              ),
            );
          } else {
            // Data is available, display user information
            User user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${user.name}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  // print year, month, day,
                  Text(
                      'Created at: ${user.createdAt.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 20)),

                  FullWidhtButton(
                      onPressed: () async => {
                            await Storage.removeJwt(),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            )
                          },
                      text: "Log out")
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
