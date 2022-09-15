import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/color_utils.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/user';
  final firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Logged In',
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.pushNamed(context, '/signInScreen');
              },
            )
          ],
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("FF8C00"),
              hexStringToColor("D2691E"),
              hexStringToColor("FF7F50")
            ], begin: Alignment.center, end: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 24),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                SizedBox(height: 8),
                Text(
                  'Name' + user.displayName!,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Email' + user.email!,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            )));
  }
}
