// ignore_for_file: prefer_const_constructors_in_immutables,unnecessary_const,library_private_types_in_public_api,avoid_print
// Copyright 2021, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
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
final _usersRef = _db.collection('users').withConverter<_User>(
      fromFirestore: (snapshots, _) => _User.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

/// Holds all example app films
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<_User>>(
        stream: _usersRef.snapshots(),
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
              return _UserItem(
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

/// A single movie row.
class _UserItem extends StatelessWidget {
  _UserItem(this.user, this.reference);

  final _User user;
  final DocumentReference<_User> reference;

  /// Returns the movie poster.
  Widget get pfp {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        user.pfp,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
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
          power,
        ],
      ),
    );
  }

  // Return the user name.
  Widget get name {
    return Text(
      user.name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xfff5f5f5)),
    );
  }

  Widget get power {
    int power = 0;
    for (var i in user.devices) {
      Map<String, Object?> device = i as Map<String, Object?>;
      try {
        List<int> powerList = (device['power'] as List<dynamic>).map((item) => item as int).toList();
        power += powerList.last;
      } catch (e) {
        print('Power Array Empty for: ${user.name}');
      }
    }

    return Text(
      'Active Power Consumption: ${power.toString()}',
      style: const TextStyle(fontSize: 12, color: Color(0xfff5f5f5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pfp,
          Flexible(child: details),
        ],
      ),
    );
  }
}

@immutable
class _User {
  _User({
    required this.pfp,
    required this.friends,
    required this.home,
    required this.name,
    required this.devices,
  });

  _User.fromJson(Map<String, Object?> json)
      : this(
          pfp: json['pfp']! as String,
          home: json['home']! as String,
          friends: json['friends']! as List<dynamic>,
          name: json['name']! as String,
          devices: json['devices']! as List<dynamic>,
        );

  final String pfp;
  final List<dynamic> friends;
  final String home;
  final String name;
  final List<dynamic> devices;

  Map<String, Object?> toJson() {
    return {
      'home': home,
      'friends': friends,
      'pfp': pfp,
      'name': name,
      'devices': devices
    };
  }
}
