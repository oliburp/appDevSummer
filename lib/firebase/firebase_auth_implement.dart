import '/import/export.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast('The email is already taken.');
      } else {
        showToast('An error occured: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> logInEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        showToast('Invalid email or password.');
      } else {
        showToast('An error occured: ${e.code}');
      }
    }
    return null;
  }
}