import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import '../../components/parts/app_button.dart';
import '../../components/parts/category_label.dart';
import '../../models/recipe_card_item.dart';
import '../add_meal/add_meal_page.dart';
import '../history/history_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SuggestionAreaView(),
          SizedBox(height: 28),
          _RecentMenusAreaView(),
          SizedBox(height: 36),
          _RegistrationHistoryAreaView(),
        ],
      ),
    );
  }
}

class _SuggestionAreaView extends StatelessWidget {
  const _SuggestionAreaView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            '今日は何を作る？',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 6),
        Center(
          child: Text(
            '最近作っていない料理を提案します',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        SizedBox(height: 28),
        _SuggestionCard(),
      ],
    );
  }
}

class _RegistrationHistoryAreaView extends StatelessWidget {
  const _RegistrationHistoryAreaView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_Separator(), SizedBox(height: 28), _HomeActionButtons()],
    );
  }
}

class _RecentMenusAreaView extends StatelessWidget {
  const _RecentMenusAreaView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '最近の献立',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _RecentMenusList(),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.orange.shade100,
            child: const Icon(Icons.restaurant, size: 40, color: Colors.orange),
          ),
          const SizedBox(height: 20),
          const Text(
            'チキンカレー',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const CategoryLabel(
            category: '和食',
            tagColor: Colors.orange,
            tagBgColor: Color(0xFFFFF3E0), // Colors.orange.shade50
          ),
          const SizedBox(height: 16),
          Text(
            '最後に作ったのは 8日前',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: AppButton.secondary(
                  label: '別の提案',
                  icon: Icons.refresh,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primary(
                  label: 'これに決定！',
                  icon: Icons.check,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.black12, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'またはこちらから',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        Expanded(child: Divider(color: Colors.black12, thickness: 1)),
      ],
    );
  }
}

class _HomeActionButtons extends StatelessWidget {
  const _HomeActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: AppButton.primary(
            label: '今日の献立を登録',
            icon: Icons.add,
            color: Colors.blue,
            onPressed: () {
              BasicPage.push(context, const AddMealPage());
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: AppButton.secondary(
            label: '履歴を見る',
            icon: Icons.list,
            color: Colors.blue,
            onPressed: () {
              BasicPage.push(context, const HistoryPage());
            },
          ),
        ),
      ],
    );
  }
}

class _RecentMenusList extends StatelessWidget {
  const _RecentMenusList();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final items = [
      RecipeInfo(
        id: '1',
        title: 'ハンバーグ',
        category: '洋食',
        date: now.subtract(const Duration(days: 1)),
      ),
      RecipeInfo(
        id: '2',
        title: '生姜焼き',
        category: '和食',
        date: now.subtract(const Duration(days: 2)),
      ),
      RecipeInfo(
        id: '3',
        title: '麻婆豆腐',
        category: '中華',
        date: now.subtract(const Duration(days: 3)),
      ),
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildRecentItem(item),
        );
      }).toList(),
    );
  }

  Widget _buildRecentItem(RecipeInfo item) {
    final diff = DateTime.now().difference(item.date!).inDays;
    final dateStr = diff == 0 ? '今日' : (diff == 1 ? '昨日' : '$diff日前');

    Color tagBg = Colors.grey.shade200;
    Color tagText = Colors.grey;
    if (item.category == '和食') {
      tagBg = const Color(0xFFE8F5E9);
      tagText = Colors.green;
    } else if (item.category == '洋食') {
      tagBg = const Color(0xFFF3E5F5);
      tagText = Colors.purple;
    } else if (item.category == '中華') {
      tagBg = const Color(0xFFFFEBEE);
      tagText = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateStr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          CategoryLabel(
            category: item.category ?? '',
            tagColor: tagText,
            tagBgColor: tagBg,
          ),
        ],
      ),
    );
  }
}
