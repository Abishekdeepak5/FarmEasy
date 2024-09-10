import 'package:firebase_auth/firebase_auth.dart';
import 'package:farmeasy/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // UserModel? _userFromFirebaseUser(UserModel? user) {
  //   return user != null ? UserModel(uid: user.uid, email: user.email ?? '') : null;
  // }

  // Stream<UserModel?> get user {
  //   return _auth.authStateChanges().map(_userFromFirebaseUser);
  // }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // User? user = result.user;
      // return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      // return null;
    }
  }
}
