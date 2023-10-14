import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'homescreen.dart';

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
    return MaterialApp(
      title: 'Watt Wizard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff9370db)),
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
      if(snapshot.hasData) {
        return const HomeScreen();
      }
      return const MyHomePage(title: 'Sign in to Watt Wizard');
    }
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  void _signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    await FirebaseAuth.instance.signInWithProvider(githubProvider);
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
