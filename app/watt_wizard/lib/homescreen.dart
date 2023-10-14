import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:watt_wizard/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }

      _adapterStateStateSubscription =
          FlutterBluePlus.adapterState.listen((state) {
        _adapterState = state;
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: (user.displayName == null)
              ? null
              : () async {
                  await FirebaseAuth.instance.signOut();
                },
        ),
        title: const Text("Home Screen"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(username: user.displayName!)),
                );
              },
              icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome ${user.displayName}",
          ),
          _adapterState == BluetoothAdapterState.on
              ? const Spacer()
              : FilledButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await FlutterBluePlus.turnOn();
                    } else {}
                  },
                  child: const Text("Turn Bluetooth On"),
                )
        ],
      )),
    );
  }
}
