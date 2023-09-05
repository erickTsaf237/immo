

import 'package:firebase_auth/firebase_auth.dart';

emailPasswordSignIn(emailAddress, password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    var a = await credential.user!.sendEmailVerification().then((value) {
      print('--------------------------------------------------------------');
    });
    // print(a!.toString());
    return credential.user!;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return null;
}