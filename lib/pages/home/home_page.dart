import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
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
      const SizedBox(width: 8),
    ];
  }

  @override
  Widget buildPage(BuildContext context) {
    return const HomeView();
  }
}
