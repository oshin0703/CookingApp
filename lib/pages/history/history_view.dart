import 'package:flutter/material.dart';

import '../../components/parts/category_label.dart';
import '../../models/recipe_card_item.dart';
import '../../repositories/meal_history_repository.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final MealHistoryRepository _repository = MealHistoryRepository();
  List<RecipeInfo>? _history;
  bool _isLoading = true;
  String? _error;
  String _selectedCategory = 'すべて';

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final history = await _repository.fetchHistory();
      if (mounted) {
        setState(() {
          _history = history;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'エラーが発生しました';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }

    final fullList = _history ?? [];
    final filteredList = _selectedCategory == 'すべて'
        ? fullList
        : fullList.where((item) => item.category == _selectedCategory).toList();

    return Container(
      color: const Color(0xFFF5F5F5),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _HistoryHeader(
            totalCount: filteredList.length,
            selectedCategory: _selectedCategory,
            onCategoryChanged: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          const SizedBox(height: 32),
          ..._buildHistoryList(filteredList),
        ],
      ),
    );
  }

  List<Widget> _buildHistoryList(List<RecipeInfo> list) {
    if (list.isEmpty) return [const Center(child: Text('履歴がありません'))];

    final widgets = <Widget>[];
    DateTime? currentDate;

    final now = DateTime.now();
    for (var item in list) {
      final date = item.date!;
      final diff = DateTime(
        now.year,
        now.month,
        now.day,
      ).difference(DateTime(date.year, date.month, date.day)).inDays;
      String dateText = '';
      if (diff == 0) {
        dateText = '今日';
      } else if (diff == 1) {
        dateText = '昨日';
      } else {
        dateText = '${date.month}月${date.day}日';
      }

      if (currentDate == null ||
          currentDate.year != date.year ||
          currentDate.month != date.month ||
          currentDate.day != date.day) {
        if (widgets.isNotEmpty) {
          widgets.add(const SizedBox(height: 24));
        }
        widgets.add(_DateDivider(dateText: dateText));
        widgets.add(const SizedBox(height: 16));
        currentDate = date;
      } else {
        widgets.add(const SizedBox(height: 12));
      }

      widgets.add(_HistoryItemCard(item: item));
    }

    return widgets;
  }
}

class _HistoryHeader extends StatelessWidget {
  final int totalCount;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const _HistoryHeader({
    required this.totalCount,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '全 $totalCount件',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'すべて',
                isSelected: selectedCategory == 'すべて',
                onTap: () => onCategoryChanged('すべて'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: '和食',
                isSelected: selectedCategory == '和食',
                onTap: () => onCategoryChanged('和食'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: '洋食',
                isSelected: selectedCategory == '洋食',
                onTap: () => onCategoryChanged('洋食'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: '中華',
                isSelected: selectedCategory == '中華',
                onTap: () => onCategoryChanged('中華'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  final String dateText;
  const _DateDivider({required this.dateText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dateText,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}

class _HistoryItemCard extends StatelessWidget {
  final RecipeInfo item;

  const _HistoryItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = item.date!;
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final monthString = '${date.month}/';
    final dayString = '${date.day}';

    // Simple weekday mapping
    const weekdays = ['日', '月', '火', '水', '木', '金', '土'];
    final weekdayString = weekdays[date.weekday % 7];

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isToday ? Colors.deepOrange : Colors.grey.shade500,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      monthString,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      dayString,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                Text(
                  weekdayString,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                CategoryLabel(
                  category: item.category ?? '',
                  tagColor: tagText,
                  tagBgColor: tagBg,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
