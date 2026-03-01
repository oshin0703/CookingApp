import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 認証状態の変化を監視
  Stream<User?> get user => _auth.authStateChanges();

  // メール・パスワードでログイン
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // メール・パスワードで新規登録
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ユーザー名の設定
      await credential.user?.updateDisplayName(name);
      return credential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ログアウト
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
