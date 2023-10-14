// ignore_for_file: prefer_const_constructors_in_immutables,unnecessary_const,library_private_types_in_public_api,avoid_print
// Copyright 2021, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: defaultFirebaseOptions);
// }

final _db = FirebaseFirestore.instance;

/// A reference to the list of movies.
/// We are using `withConverter` to ensure that interactions with the collection
/// are type-safe.
final _homesRef = _db.collection('homes').withConverter<_Home>(
      fromFirestore: (snapshots, _) => _Home.fromJson(snapshots.data()!, snapshots.id),
      toFirestore: (home, _) => home.toJson(),
    );

/// Holds all example app films
class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<_Home>>(
        stream: _homesRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return _HomeItem(
                data.docs[index].data(),
                data.docs[index].reference,
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> updateHome(_Home home) async {
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  var userSnapshot = await _db.collection('users').doc(userUID).get();
  String userHome = userSnapshot.get('home') as String;

  await _db.collection('users').doc(userUID).update({
    'home': home.id,
  });

  await _db.collection('homes').doc(userHome).update({
    'users': FieldValue.arrayRemove([
      userUID
    ])
  }).onError((error, stackTrace) => null);

  await _db.collection('homes').doc(home.id).update({
    'users': FieldValue.arrayUnion([
      userUID
    ])
  });
}

/// A single movie row.
class _HomeItem extends StatelessWidget {
  _HomeItem(this.home, this.reference);

  final _Home home;
  final DocumentReference<_Home> reference;

  /// Returns the movie poster.
  Widget get pfp {
    return SizedBox(
      width: 100,
      child: Image.network(home.pfp),
    );
  }

  /// Returns user details.
  Widget get details {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          name,
        ],
      ),
    );
  }

  // Return the home name.
  Widget get name {
    return Text(
      '${home.name}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget updateHomeButton(BuildContext context, _Home home) {
    return FloatingActionButton(
      onPressed: () async {
        await updateHome(home);
      },
      child: const Text("SELECT"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pfp,
          Flexible(child: details),
          updateHomeButton(context, home),
        ],
      ),
    );
  }
}

@immutable
class _Home {
  _Home({required this.pfp, required this.users, required this.name, required this.id});

  _Home.fromJson(Map<String, Object?> json, String id)
      : this(
          pfp: json['pfp']! as String,
          users: json['users']! as List<dynamic>,
          name: json['name']! as String,
          id: id,
        );

  final String pfp;
  final List<dynamic> users;
  final String name;
  final String id;

  Map<String, Object?> toJson() {
    return {
      'users': users,
      'pfp': pfp,
      'name': name,
    };
  }
}
