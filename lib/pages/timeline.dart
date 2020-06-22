import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

final CollectionReference usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  //List<dynamic> users = [];

  @override
  void initState() {
    //getUsers();
    //getUserById();
    //createUser();
    //updateUser();
    deleteUser();
    super.initState();
  }

  createUser() async {
    await usersRef.document("asdfasfd").setData({
      "username": "Jeff",
      "postsCount": 0,
      "isAdmin": false,
    });
  }
//    await usersRef.add({
//      "username": "Jeff",
//      "postsCount": 0,
//      "isAdmin": false,
//    });
  updateUser() async {
    final DocumentSnapshot doc = await usersRef.document("TboQekjBm2ExRRAbbSs9").get();
    if(doc.exists) {
      doc.reference..updateData({
        "username": "John",
        "postsCount": 0,
        "isAdmin": false,
      });
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc = await usersRef.document("TboQekjBm2ExRRAbbSs9").get();
    if(doc.exists) {
      doc.reference.delete();
    }
  }

//  Future<QuerySnapshot> getUsers() async {
////    final QuerySnapshot snapshot = await usersRef
////        .where("postsCount", isLessThan: 3)
////        .where("username", isEqualTo: "Fred")
////        .getDocuments();
////    final QuerySnapshot snapshot = await usersRef
////        .orderBy("postsCount", descending: true)
////        .getDocuments();
////    final QuerySnapshot snapshot = await usersRef
////        .limit(1)
////        .getDocuments();
//    final QuerySnapshot snapshot = await usersRef.getDocuments();
//    setState(() {
//      users = snapshot.documents;
//    });
////    snapshot.documents.forEach((DocumentSnapshot doc) {
////      print(doc.data);
////      print(doc.documentID);
////      print(doc.exists);
////    });
//  }

//  getUserById() async {
//    final String id = "tk2NYECZMxmSz7FMHk3n";
//    final DocumentSnapshot doc = await usersRef.document(id).get();
//    print(doc.data);
//    print(doc.documentID);
//    print(doc.exists);
//  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents.map((doc) => Text(doc['username'])).toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
