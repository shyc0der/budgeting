// ignore_for_file: file_names
import 'package:budget/src/modules/responseModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

export 'package:firebase_auth/firebase_auth.dart' show User;


class FirebaseUser {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Stream<User?> userLoginState() {
    return auth.userChanges();
  }

  static Future<ResponseModel> createUser(String email, String password) async {
    try {
      FirebaseApp firebaseApp = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);
      FirebaseAuth _auth = FirebaseAuth.instanceFor(app: firebaseApp);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await firebaseApp.delete();
      return ResponseModel(ResponseType.success, userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ResponseModel(ResponseType.warning, 'Weak Password');
      } else if (e.code == 'email-already-in-use') {
        return ResponseModel(ResponseType.warning, 'Email Already In Use');
      }
      return ResponseModel(ResponseType.error, e);
    } catch (e) {
      return ResponseModel(ResponseType.error, e);
    }
  }
}
