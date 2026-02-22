import 'package:flutter/material.dart';

import '../../models/recipe_card_item.dart';

class RecipeDetailView extends StatelessWidget {
  final RecipeInfo recipe;
  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: constraints.maxWidth < 500 ? 0 : 2,
                    child: Container(
                      width: constraints.maxWidth < 500 ? 120 : 220,
                      height: constraints.maxWidth < 500 ? 100 : 180,
                      decoration: BoxDecoration(
                        color: recipe.backgroundColor ?? Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          recipe.icon ?? '',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 500 ? 32 : 64,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 500 ? 18 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipe.description ?? '',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 500 ? 13 : 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 24,
                          children: [
                            if (recipe.time != null)
                              _infoIconText(Icons.timer, recipe.time!),
                            if (recipe.servings != null)
                              _infoIconText(Icons.people, recipe.servings!),
                            if (recipe.difficulty != null)
                              _infoIconText(Icons.star, recipe.difficulty!),
                            if (recipe.category != null)
                              _infoIconText(Icons.category, recipe.category!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '材料',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (recipe.ingredients != null)
                      ...recipe.ingredients!.map(
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                i.name,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                i.amount,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Colors.orangeAccent),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
