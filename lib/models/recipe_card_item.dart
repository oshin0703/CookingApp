import 'package:flutter/material.dart';

class RecipeInfo {
  final String? id;
  final String title;
  final String? description;
  final String? icon;
  final Color? backgroundColor;
  final String? imagePath;
  final String? time;
  final String? servings;
  final String? difficulty;
  final String? category;
  final DateTime? date;
  final List<RecipeIngredient>? ingredients;
  final List<RecipeStep>? steps;

  const RecipeInfo({
    this.id,
    required this.title,
    this.description,
    this.icon,
    this.backgroundColor,
    this.imagePath,
    this.time,
    this.servings,
    this.difficulty,
    this.category,
    this.date,
    this.ingredients,
    this.steps,
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
