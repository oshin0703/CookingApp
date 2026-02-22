import 'package:flutter/material.dart';

class AddRecipeDialog extends StatefulWidget {
  const AddRecipeDialog({super.key});

  @override
  State<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _timeController = TextEditingController();
  final _servingsController = TextEditingController();
  String _difficulty = '中級';
  String _category = 'メイン料理';

  final List<Map<String, String>> _ingredients = [
    {'name': '', 'amount': ''},
  ];
  final List<Map<String, String>> _steps = [
    {'title': '', 'desc': ''},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _timeController.dispose();
    _servingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dialogWidth = constraints.maxWidth < 500
              ? constraints.maxWidth * 0.98
              : (constraints.maxWidth < 700 ? 420.0 : 600.0);
          return Container(
            width: dialogWidth,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'レシピを追加',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'レシピ名 *',
                        hintText: '例：チキンカレー',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'レシピ名は必須です' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: '説明',
                        hintText: 'レシピの説明を入力してください…',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            controller: _timeController,
                            decoration: const InputDecoration(
                              labelText: '調理時間',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextFormField(
                            controller: _servingsController,
                            decoration: const InputDecoration(
                              labelText: '人数',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: DropdownButtonFormField<String>(
                            initialValue: _difficulty,
                            items: ['初級', '中級', '上級']
                                .map(
                                  (d) => DropdownMenuItem(
                                    value: d,
                                    child: Text(d),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _difficulty = v ?? '中級'),
                            decoration: const InputDecoration(
                              labelText: '難易度',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: DropdownButtonFormField<String>(
                            initialValue: _category,
                            items: ['メイン料理', '副菜', 'デザート', '朝食']
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(c),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _category = v ?? 'メイン料理'),
                            decoration: const InputDecoration(
                              labelText: 'カテゴリ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '材料',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ..._ingredients.asMap().entries.map((entry) {
                      final idx = entry.key;
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: entry.value['name'],
                              decoration: const InputDecoration(
                                hintText: '材料名',
                              ),
                              onChanged: (v) =>
                                  setState(() => _ingredients[idx]['name'] = v),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              initialValue: entry.value['amount'],
                              decoration: const InputDecoration(hintText: '分量'),
                              onChanged: (v) => setState(
                                () => _ingredients[idx]['amount'] = v,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () =>
                                setState(() => _ingredients.removeAt(idx)),
                          ),
                        ],
                      );
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('追加'),
                        onPressed: () => setState(
                          () => _ingredients.add({'name': '', 'amount': ''}),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '作り方',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ..._steps.asMap().entries.map((entry) {
                      final idx = entry.key;
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: entry.value['title'],
                              decoration: InputDecoration(
                                hintText: 'ステップ${idx + 1}タイトル',
                              ),
                              onChanged: (v) =>
                                  setState(() => _steps[idx]['title'] = v),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              initialValue: entry.value['desc'],
                              decoration: const InputDecoration(hintText: '説明'),
                              onChanged: (v) =>
                                  setState(() => _steps[idx]['desc'] = v),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () =>
                                setState(() => _steps.removeAt(idx)),
                          ),
                        ],
                      );
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('ステップ追加'),
                        onPressed: () => setState(
                          () => _steps.add({'title': '', 'desc': ''}),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // TODO: 保存処理
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('保存'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
