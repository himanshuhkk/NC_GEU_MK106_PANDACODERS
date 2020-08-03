import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileData {
  final String Name;
  final String title;
  final String id;

  static double time = 120.0; // seconds

  ProfileData(this.Name, this.title, this.id);

  static Future<ProfileData> fetchProfile() async {
    String pName, pId, pTitle;
    var ds, _currentUser;
    await FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => _currentUser = currentUser)
        .catchError((err) => print(err));
    await Firestore.instance
        .collection("users")
        .document(_currentUser.uid)
        .get()
        .then((snapshot) {
            ds = snapshot;
        })
        .catchError((err) => print(err));

//    print(ds.data);

    pName = ds['name'].toString();
    pTitle = ds['title'].toString();
    pId = ds['email'].toString();

    return ProfileData(pName, pTitle, pId);
  }
}
