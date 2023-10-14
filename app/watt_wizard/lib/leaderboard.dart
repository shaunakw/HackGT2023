// ignore_for_file: prefer_const_constructors_in_immutables,unnecessary_const,library_private_types_in_public_api,avoid_print
// Copyright 2021, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: defaultFirebaseOptions);
// }

final db = FirebaseFirestore.instance;

/// A reference to the list of movies.
/// We are using `withConverter` to ensure that interactions with the collection
/// are type-safe.
final usersRef = db.collection('users').withConverter<_User>(
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
        stream: usersRef.snapshots(),
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
    return SizedBox(
      width: 100,
      child: Image.network(user.pfp),
    );
  }

  /// Returns user details.
  Widget get details {
    return const Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name,
        ],
      ),
    );
  }

  /// Return the user name.
  // Widget get name {
  //   return Text(
  //     '${user.name}',
  //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
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
  _User({required this.pfp, required this.friends, required this.household
      // required this.name,
      });

  _User.fromJson(Map<String, Object?> json)
      : this(
          pfp: json['pfp']! as String,
          household: json['household']! as String,
          friends: json['friends']! as String,
          // name: json['name']! as String,
        );

  final String pfp;
  final String friends;
  final String household;
  // final String name;

  Map<String, Object?> toJson() {
    return {
      'household': household,
      'friends': friends,
      'pfp': pfp,
      // 'name': name,
    };
  }
}
