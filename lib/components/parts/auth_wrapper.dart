import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/login/login_page.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        // 接続中
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFFF6D33)),
            ),
          );
        }

        // ユーザーがログインしている場合
        if (snapshot.hasData) {
          return const HomePage();
        }

        // ログインしていない場合
        return const LoginPage();
      },
    );
  }
}
