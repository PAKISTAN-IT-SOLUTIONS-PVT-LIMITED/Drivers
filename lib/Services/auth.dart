import 'package:driver/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//SIGN IN KA Function
Future<User> signInWithGoogle() async {
  try {
    //SIGNING IN WITH GOOGLE
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    //CREATING CREDENTIAL FOR FIREBASE
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    //SIGNING IN WITH CREDENTIAL & MAKING A USER IN FIREBASE  AND GETTING USER CLASS
    final userCredential = await _auth.signInWithCredential(credential);
    final User user = userCredential.user;

    //CHECKING IS ON
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(currentUser.uid == user.uid);
    print(user);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userEmail", user.email);
    sharedPreferences.setString("userName", user.displayName);
    sharedPreferences.setString("userPhoto", user.photoURL);
    sharedPreferences.setString("userId", user.uid);
    sharedPreferences.setString("userPhone", user.phoneNumber);


    return user;
  } catch (e) {
    print(e);
  }
}

Future signOut() async {
  await googleSignIn.signOut();
  await _auth.signOut();
  return new Login();
}
