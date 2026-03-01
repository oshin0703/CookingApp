import '../lib/models/recipe_card_item.dart';

class MockMealData {
  static List<RecipeInfo> getItems() {
    final now = DateTime.now();
    return [
      RecipeInfo(id: '1', title: 'チキンカレー', category: '和食', date: now),
      RecipeInfo(
        id: '2',
        title: 'ハンバーグ',
        category: '洋食',
        date: now.subtract(const Duration(days: 1)),
      ),
      RecipeInfo(
        id: '3',
        title: '麻婆豆腐',
        category: '中華',
        date: now.subtract(const Duration(days: 3)),
      ),
      RecipeInfo(
        id: '4',
        title: '鮭の塩焼き',
        category: '和食',
        date: now.subtract(const Duration(days: 4)),
      ),
      RecipeInfo(
        id: '5',
        title: 'カルボナーラ',
        category: '洋食',
        date: now.subtract(const Duration(days: 5)),
      ),
    ];
  }
}
