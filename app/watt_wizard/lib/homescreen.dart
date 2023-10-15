import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:watt_wizard/profile.dart';

import 'widgets/users_leaderboard.dart';
import 'widgets/homes_leaderboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  late String userInput;

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Data'),
          content: TextField(
            onChanged: (value) {
              userInput = value;
            },
            decoration: InputDecoration(hintText: "Enter something"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                makeNewHome(userInput);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }

      _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appBarHeight = AppBar().preferredSize.height; // Default is 56.0
    double tabBarHeight = 48.0; // Default height for TabBar

    double sizedBoxHeight = screenHeight - (2 * appBarHeight) - tabBarHeight;
    double sizedBoxWidth = screenWidth;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
          title: Text('Welcome, ${user.displayName ?? ""}'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(username: user.displayName!)),
                  );
                },
                icon: const Icon(Icons.account_circle)),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              // Tab(
              //   icon: Icon(Icons.cloud_outlined),
              // ),
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text(
            //         "Welcome ${user.displayName}",
            //       ),
            //       _adapterState == BluetoothAdapterState.on
            //           ? const Spacer()
            //           : FilledButton(
            //               onPressed: () async {
            //                 if (Platform.isAndroid) {
            //                   await FlutterBluePlus.turnOn();
            //                 } else {}
            //               },
            //               child: const Text("Turn Bluetooth On"),
            //             ),
            //     ],
            //   ),
            // ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: sizedBoxWidth,
                    height: sizedBoxHeight,
                    child: const UserList(),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: sizedBoxWidth,
                    height: sizedBoxHeight - 42,
                    child: const HomeList(),
                  ),
                  ElevatedButton(
                    onPressed: _showDialog,
                    child: const Text("Add Home"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
