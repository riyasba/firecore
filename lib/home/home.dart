import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Hmome extends StatefulWidget {
  const Hmome({super.key});

  @override
  State<Hmome> createState() => _HmomeState();
}

class _HmomeState extends State<Hmome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  User? _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google SignIn'),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }
  Widget _googleSignInButton() {
  return Center(
    child: SizedBox(
      height: 50,
      child: SignInButton(
        Buttons.google,
        onPressed: _handleGoogleSignIn,
        text: 'Sign up with Google',
      ),
    ),
  );
}

Widget _userInfo() {
  return Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
    children: [CircleAvatar(backgroundImage: NetworkImage(_user!.photoURL!),)],),);
}

void _handleGoogleSignIn() {
  try {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    _auth.signInWithProvider(googleAuthProvider);
  } catch (error) {
    print(error);
  }
}

}

