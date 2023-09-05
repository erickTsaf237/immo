import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  // final GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: '399661112097-ljub299djhmb6l3vqs7ulr84aoplvdv6.apps.googleusercontent.com').signIn();
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
  /*final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '399661112097-ljub299djhmb6l3vqs7ulr84aoplvdv6.apps.googleusercontent.com');
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential userCredential =
  await auth.signInWithCredential(credential);
  final User? user = userCredential.user;
  return userCredential;*/

}

