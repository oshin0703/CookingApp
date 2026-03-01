import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import '../../models/recipe_card_item.dart';
import '../../repositories/meal_history_repository.dart';
import 'add_meal_view.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '洋食';

  @override
  void initState() {
    super.initState();
    _updateDateController();
  }

  void _updateDateController() {
    final now = DateTime.now();
    final isToday =
        _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
    final suffix = isToday ? '（今日）' : '';
    _dateController.text =
        '${_selectedDate.year}年${_selectedDate.month}月${_selectedDate.day}日$suffix';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateDateController();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBasicPage(context);
  }

  Widget _buildBasicPage(BuildContext context) {
    return _AddMealBasicPage(child: buildBody());
  }

  Widget buildBody() {
    return AddMealView(
      nameController: _nameController,
      dateController: _dateController,
      selectedCategory: _selectedCategory,
      onCategorySelected: (category) {
        setState(() {
          _selectedCategory = category;
        });
      },
      onDateTap: _selectDate,
      onSubmit: () async {
        final repository = MealHistoryRepository();
        final newRecipe = RecipeInfo(
          title: _nameController.text.trim(),
          category: _selectedCategory,
          date: _selectedDate,
        );

        try {
          await repository.addMeal(newRecipe);
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('登録に失敗しました')));
          }
        }
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }
}

class _AddMealBasicPage extends BasicPage {
  final Widget child;
  const _AddMealBasicPage({required this.child});

  @override
  String? get barTitle => '献立を登録';

  @override
  Widget? leading(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back, color: Colors.grey, size: 20),
      label: const Text(
        '戻る',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context) => child;
}
