import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'homescreen.dart';

final db = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if (Platform.isAndroid) {
    //   await FlutterBluePlus.turnOn();
    // }

    return MaterialApp(
      title: 'Watt Wizard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0abde3),
        ),
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
        useMaterial3: true,
      ),
      home: _landingPage(),
    );
  }
}

Widget _landingPage() {
  return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const MyHomePage(title: 'Sign in to Watt Wizard');
      });
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  void _signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    await FirebaseAuth.instance.signInWithProvider(githubProvider);
    if (FirebaseAuth.instance.currentUser != null) {
      var userUID = await db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();
      if (!userUID.exists) {
        await db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set(
          {
            'devices': [],
            'friends': [],
            'home': "",
            'name': FirebaseAuth.instance.currentUser?.displayName,
            'pfp': 'https://m.media-amazon.com/images/I/612-e1vHBAL._AC_SL1145_.jpg'
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton.icon(
              onPressed: _signInWithGitHub,
              icon: const Icon(Icons.login),
              label: const Text("Log in with GitHub"),
            ),
          ],
        ),
      ),
    );
  }
}
