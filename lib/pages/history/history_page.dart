import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import '../add_meal/add_meal_page.dart';
import 'history_view.dart';

class HistoryPage extends BasicPage {
  const HistoryPage({super.key});

  @override
  String? get barTitle => '献立履歴';

  @override
  Widget? leading(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back, color: Colors.black54, size: 20),
      label: const Text(
        '戻る',
        style: TextStyle(color: Colors.black54, fontSize: 16),
      ),
    );
  }

  @override
  List<Widget>? actions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: GestureDetector(
          onTap: () async {
            final result = await BasicPage.push(context, const AddMealPage());
            if (result == true) {
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            }
          },
          child: const CircleAvatar(
            backgroundColor: Colors.deepOrange,
            radius: 14,
            child: Icon(Icons.add, color: Colors.white, size: 20),
          ),
        ),
      ),
    ];
  }

  @override
  Widget buildPage(BuildContext context) {
    return const HistoryView();
  }
}
