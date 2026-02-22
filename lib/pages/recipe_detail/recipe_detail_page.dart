import 'package:flutter/material.dart';

import '../../components/pages/basic_page.dart';
import '../../models/recipe_card_item.dart';
import 'recipe_detail_view.dart';

class RecipeDetailPage extends BasicPage {
  final RecipeInfo recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  String get barTitle => 'Cooking App';

  @override
  Widget buildPage(BuildContext context) {
    return RecipeDetailView(recipe: recipe);
  }
}
