import 'package:flutter/material.dart';

class RecipeCardItem {
  final String title;
  final String description;
  final String icon;
  final Color backgroundColor;
  final String imagePath;
  final String time;
  final String servings;
  final String difficulty;
  final String category;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;

  const RecipeCardItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.imagePath,
    required this.time,
    required this.servings,
    required this.difficulty,
    required this.category,
    required this.ingredients,
    required this.steps,
  });
}

class RecipeIngredient {
  final String name;
  final String amount;
  const RecipeIngredient({required this.name, required this.amount});
}

class RecipeStep {
  final String title;
  final String description;
  const RecipeStep({required this.title, required this.description});
}
