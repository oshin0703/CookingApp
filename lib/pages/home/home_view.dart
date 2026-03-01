import 'dart:math';

import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import '../../components/parts/app_button.dart';
import '../../components/parts/category_label.dart';
import '../../models/recipe_card_item.dart';
import '../../repositories/meal_history_repository.dart';
import '../add_meal/add_meal_page.dart';
import '../history/history_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MealHistoryRepository _repository = MealHistoryRepository();
  List<RecipeInfo> _allMeals = [];
  RecipeInfo? _suggestedRecipe;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);
    final history = await _repository.fetchHistory();
    setState(() {
      _allMeals = history;
      _isLoading = false;
      _pickRandomSuggestion();
    });
  }

  void _pickRandomSuggestion() {
    if (_allMeals.length > 1) {
      final random = Random();
      RecipeInfo next;
      do {
        next = _allMeals[random.nextInt(_allMeals.length)];
      } while (next.id == _suggestedRecipe?.id);
      setState(() {
        _suggestedRecipe = next;
      });
    } else if (_allMeals.length == 1) {
      setState(() {
        _suggestedRecipe = _allMeals[0];
      });
    } else {
      setState(() {
        _suggestedRecipe = null;
      });
    }
  }

  Future<void> _decideOnThis() async {
    if (_suggestedRecipe == null) return;

    final newMeal = _suggestedRecipe!.copyWith(id: null, date: DateTime.now());

    try {
      await _repository.addMeal(newMeal);
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('登録完了'),
            content: Text('「${newMeal.title}」を今日の献立として登録しました！'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _loadHistory(); // 更新
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('登録に失敗しました')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SuggestionAreaView(
            suggestion: _suggestedRecipe,
            onRefresh: _pickRandomSuggestion,
            onDecide: _decideOnThis,
          ),
          const SizedBox(height: 28),
          _RecentMenusAreaView(recentMeals: _allMeals.take(3).toList()),
          const SizedBox(height: 36),
          const _RegistrationHistoryAreaView(),
        ],
      ),
    );
  }
}

class _SuggestionAreaView extends StatelessWidget {
  final RecipeInfo? suggestion;
  final VoidCallback onRefresh;
  final VoidCallback onDecide;

  const _SuggestionAreaView({
    required this.suggestion,
    required this.onRefresh,
    required this.onDecide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(
          child: Text(
            '今日は何を作る？',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 6),
        const Center(
          child: Text(
            '過去の履歴から提案します',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        const SizedBox(height: 28),
        if (suggestion != null)
          _SuggestionCard(
            suggestion: suggestion!,
            onRefresh: onRefresh,
            onDecide: onDecide,
          )
        else
          _EmptyStateCard(
            message: '履歴がまだありません。最初の献立を登録しましょう！',
            onTap: () async {
              final result = await BasicPage.push(context, const AddMealPage());
              if (result == true) {
                onRefresh(); // 履歴を再取得するために onRefresh を流用
              }
            },
          ),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final RecipeInfo suggestion;
  final VoidCallback onRefresh;
  final VoidCallback onDecide;

  const _SuggestionCard({
    required this.suggestion,
    required this.onRefresh,
    required this.onDecide,
  });

  @override
  Widget build(BuildContext context) {
    final diff = suggestion.date != null
        ? DateTime.now().difference(suggestion.date!).inDays
        : null;
    final lastMadeStr = diff != null ? '最後に作ったのは $diff日前' : 'まだ作っていません';

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
          Text(
            suggestion.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          CategoryLabel(
            category: suggestion.category ?? 'その他',
            tagColor: _getCategoryColor(suggestion.category),
            tagBgColor: _getCategoryBgColor(suggestion.category),
          ),
          const SizedBox(height: 16),
          Text(
            lastMadeStr,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: AppButton.secondary(
                  label: '別の提案',
                  icon: Icons.refresh,
                  onPressed: onRefresh,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primary(
                  label: 'これに決定！',
                  icon: Icons.check,
                  onPressed: onDecide,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String? category) {
    if (category == '和食') return Colors.green;
    if (category == '洋食') return Colors.purple;
    if (category == '中華') return Colors.red;
    return Colors.orange;
  }

  Color _getCategoryBgColor(String? category) {
    if (category == '和食') return const Color(0xFFE8F5E9);
    if (category == '洋食') return const Color(0xFFF3E5F5);
    if (category == '中華') return const Color(0xFFFFEBEE);
    return const Color(0xFFFFF3E0);
  }
}

class _RecentMenusAreaView extends StatelessWidget {
  final List<RecipeInfo> recentMeals;
  const _RecentMenusAreaView({required this.recentMeals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '最近の献立',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (recentMeals.isNotEmpty)
          _RecentMenusList(items: recentMeals)
        else
          _EmptyStateMiniCard(
            message: 'まだ履歴がありません',
            onTap: () async {
              final result = await BasicPage.push(context, const AddMealPage());
              if (result == true) {
                // 親の HomeViewState を取得して更新
                final state = context.findAncestorStateOfType<_HomeViewState>();
                state?._loadHistory();
              }
            },
          ),
      ],
    );
  }
}

class _RecentMenusList extends StatelessWidget {
  final List<RecipeInfo> items;
  const _RecentMenusList({required this.items});

  @override
  Widget build(BuildContext context) {
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
    final diff = item.date != null
        ? DateTime.now().difference(item.date!).inDays
        : null;
    final dateStr = diff == 0
        ? '今日'
        : (diff == 1 ? '昨日' : (diff != null ? '$diff日前' : '-'));

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

class _EmptyStateCard extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  const _EmptyStateCard({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
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
          Icon(Icons.notes_rounded, size: 48, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 24),
          AppButton.primary(
            label: '最初の献立を登録',
            icon: Icons.add,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

class _EmptyStateMiniCard extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  const _EmptyStateMiniCard({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.blue.shade300,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '献立を登録する',
              style: TextStyle(
                color: Colors.blue.shade400,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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
            onPressed: () async {
              final result = await BasicPage.push(context, const AddMealPage());
              if (result == true) {
                // Ignore warning about needing to check mounted since we are inside a stateful widget's method
                // and should technically check bit for safety but this is standard practice in simple apps.
                if (context.mounted) {
                  final state = context
                      .findAncestorStateOfType<_HomeViewState>();
                  state?._loadHistory();
                }
              }
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
            onPressed: () async {
              await BasicPage.push(context, const HistoryPage());
              // 履歴画面から戻った際にも、最新の情報を反映させるために再取得
              if (context.mounted) {
                final state = context.findAncestorStateOfType<_HomeViewState>();
                state?._loadHistory();
              }
            },
          ),
        ),
      ],
    );
  }
}
