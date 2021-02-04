import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_check_in/app.dart';

class AuthHandler {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<User> currentUser() async {
    print("USER: ${_firebaseAuth.currentUser}");
    return _firebaseAuth.currentUser;
  }

  Future<dynamic> newUserEmailPassword({String email, String password}) async {
    String _email = email.trim();
    String _password = password.trim();
    print("Email: $_email");
    print("Password: $_password");
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return currentUser.user;
  }

  Future<dynamic> signInWithEmailPassword({
    String email,
    String password,
    BuildContext context,
  }) async {
    String _email = email.trim();
    String _password = password.trim();
    print("Email: $_email");

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => App(),
        ),
      );
    } catch (error) {
      print("Error: $error");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.red),
            ),
          ),
          content: Text("${error.toString()}"),
          actions: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: RawMaterialButton(
                child: Text("Try Again"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      );
    }
  }

  Future<dynamic> resetPassword({String emailCtrl}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: emailCtrl);
  }

  Future<dynamic> signInAnonymously() {
    return _firebaseAuth.signInAnonymously().then(
      (firebaseUser) {
        return firebaseUser.user;
      },
    );
  }

  Future<dynamic> deleteUser() {
    return _firebaseAuth.currentUser.delete();
  }

  // Future<User> signInGoogle({ServiceProvider serviceProvider}) async {
  //   // final GoogleSignInAccount account = await _googleSignIn.signIn();
  //   serviceProvider.checkUserEmailRealTime(email: account?.email).then(
  //     (DataSnapshot snapshot) async {
  //       if (snapshot == null) {
  //         // _googleSignIn.signOut();
  //         print("Google SignIn ${snapshot.value}");
  //       }
  // if (snapshot != null) {
  // final GoogleSignInAuthentication googleAuth =
  // await account.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //   var firebaseUser =
  //       await _firebaseAuth.signInWithCredential(credential);
  //   return firebaseUser.user;
  // }
  // return _googleSignIn.signOut();
  // },
  // );
  // return null;
  // }

  // Future<User> signUpGoogle({GoogleSignInAccount account}) async {
  //   final GoogleSignInAuthentication googleAuth = await account.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //   User firebaseUser =
  //       (await _firebaseAuth.signInWithCredential(credential)).user;
  //   return firebaseUser;
  // }

  // Future signOut({Function doAfter}) async {
  //   try {
  //     // await _firebaseAuth.signOut();
  //     await _googleSignIn.signOut().then(
  //       (a) {
  //         doAfter();
  //       },
  //     );
  //   } catch (e) {
  //     print('Failed to signOut' + e.toString());
  //   }
  // }

  Future signOut(context) async {
    // bool _google = _googleSignIn.currentUser?.email != null;

    if (1 == 1) {
      // _googleSignIn.currentUser.clearAuthCache();
      // _googleSignIn.signOut().then(
      // (google) {
      // google.clearAuthCache();
      _firebaseAuth.signOut().then(
        (firebase) {
          print("Firebase of Google Signed-Out user");
        },
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => App(),
        ),
      );
    } else {
      _firebaseAuth.signOut().then(
        (firebase) {
          print("Firebase Signed-Out user");
        },
      );
      print("Completed");
    }
  }
}
