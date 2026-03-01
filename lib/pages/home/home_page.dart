import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import '../../services/auth_service.dart';
import '../history/history_page.dart';
import 'home_view.dart';

class HomePage extends BasicPage {
  const HomePage({super.key});

  @override
  String? get barTitle => null;

  @override
  Widget? titleWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/icons/home_icon.png', height: 28),
        const SizedBox(width: 8),
        const Text(
          'Cooking App',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  @override
  List<Widget>? actions(BuildContext context) {
    return [
      TextButton.icon(
        onPressed: () {
          BasicPage.push(context, const HistoryPage());
        },
        icon: const Icon(Icons.history, color: Colors.grey),
        label: const Text(
          '履歴',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      IconButton(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('ログアウト'),
              content: const Text('ログアウトしますか？'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'ログアウト',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );

          if (result == true) {
            await AuthService().signOut();
          }
        },
        icon: const Icon(Icons.logout, color: Colors.grey),
        tooltip: 'ログアウト',
      ),
      const SizedBox(width: 8),
    ];
  }

  @override
  Widget buildPage(BuildContext context) {
    return const HomeView();
  }
}
