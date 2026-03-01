import 'package:cloud_firestore/cloud_firestore.dart';
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

  RecipeInfo copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    Color? backgroundColor,
    String? imagePath,
    String? time,
    String? servings,
    String? difficulty,
    String? category,
    DateTime? date,
    List<RecipeIngredient>? ingredients,
    List<RecipeStep>? steps,
  }) {
    return RecipeInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      imagePath: imagePath ?? this.imagePath,
      time: time ?? this.time,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      date: date ?? this.date,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'backgroundColor': backgroundColor?.value,
      'imagePath': imagePath,
      'time': time,
      'servings': servings,
      'difficulty': difficulty,
      'category': category,
      'date': date?.toIso8601String(),
      'ingredients': ingredients?.map((x) => x.toMap()).toList(),
      'steps': steps?.map((x) => x.toMap()).toList(),
    };
  }

  factory RecipeInfo.fromMap(Map<String, dynamic> map, {String? id}) {
    return RecipeInfo(
      id: id,
      title: map['title'] ?? '',
      description: map['description'],
      icon: map['icon'],
      backgroundColor: map['backgroundColor'] != null
          ? Color(map['backgroundColor'])
          : null,
      imagePath: map['imagePath'],
      time: map['time'],
      servings: map['servings'],
      difficulty: map['difficulty'],
      category: map['category'],
      date: map['date'] != null
          ? (map['date'] is String
                ? DateTime.parse(map['date'])
                : (map['date'] as Timestamp).toDate())
          : null,
      ingredients: map['ingredients'] != null
          ? List<RecipeIngredient>.from(
              map['ingredients']?.map((x) => RecipeIngredient.fromMap(x)),
            )
          : null,
      steps: map['steps'] != null
          ? List<RecipeStep>.from(
              map['steps']?.map((x) => RecipeStep.fromMap(x)),
            )
          : null,
    );
  }
}

class RecipeIngredient {
  final String name;
  final String amount;
  const RecipeIngredient({required this.name, required this.amount});

  Map<String, dynamic> toMap() {
    return {'name': name, 'amount': amount};
  }

  factory RecipeIngredient.fromMap(Map<String, dynamic> map) {
    return RecipeIngredient(
      name: map['name'] ?? '',
      amount: map['amount'] ?? '',
    );
  }
}

class RecipeStep {
  final String title;
  final String description;
  const RecipeStep({required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }

  factory RecipeStep.fromMap(Map<String, dynamic> map) {
    return RecipeStep(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
