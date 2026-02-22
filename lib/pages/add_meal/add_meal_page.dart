import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import 'add_meal_view.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController(text: '2024年1月20日（今日）');
  String _selectedCategory = '洋食'; // Based on image selection

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
      onSubmit: () {},
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
