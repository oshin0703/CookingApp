import 'package:flutter/material.dart';

import '../components/add_recipe_dialog.dart';
import '../components/basic_page.dart';
import '../components/page_horizontal_list.dart';
import '../models/recipe_card_item.dart';
import 'recipe_detail.dart';

class HomePage extends BasicPage {
  const HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'お気に入りレシピ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '保存したレシピを管理',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 16),
              // ページ遷移ボタン付きの横ページ表示ウィジェット
              SizedBox(
                height: 200,
                child: PageHorizontalList(
                  items: [
                    RecipeCardItem(
                      title: 'チキンカレー',
                      description: 'スパイシーで濃厚な本格カレー',
                      icon: '🍛',
                      backgroundColor: const Color(0xFFFFECDD),
                      imagePath: '',
                      time: '45分',
                      servings: '4人分',
                      difficulty: '中級',
                      category: 'メイン料理',
                      ingredients: [
                        RecipeIngredient(name: '鶏もも肉（一口大に切る）', amount: '400g'),
                        RecipeIngredient(name: '玉ねぎ（薄切り）', amount: '2個'),
                        RecipeIngredient(name: 'カレールー', amount: '1箱'),
                        RecipeIngredient(name: '水', amount: '800ml'),
                        RecipeIngredient(name: 'サラダ油', amount: '大さじ2'),
                        RecipeIngredient(name: '塩・こしょう', amount: '適量'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '材料を準備する',
                          description:
                              '鶏もも肉を一口大に切り、玉ねぎを薄切りにする。塩こしょうで鶏肉に下味をつける。',
                        ),
                        RecipeStep(
                          title: '鶏肉を炒める',
                          description: 'フライパンにサラダ油を熱し、鶏肉を入れて表面に焼き色がつくまで炒める。',
                        ),
                        RecipeStep(
                          title: '玉ねぎを加える',
                          description: '玉ねぎを加えてしんなりするまで炒める。透明感が出てきたらOK。',
                        ),
                        RecipeStep(
                          title: '煮込む',
                          description: '水を加えて沸騰させ、アクを取りながら20分程度煮込む。',
                        ),
                        RecipeStep(
                          title: 'カレールーを加える',
                          description:
                              '一度火を止めてカレールーを加え、よく溶かしてから再び弱火で10分煮込んで完成。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'パンケーキ',
                      description: 'ふわふわで美味しい朝食の定番',
                      icon: '☕',
                      backgroundColor: const Color(0xFFF8E8FF),
                      imagePath: '',
                      time: '20分',
                      servings: '2人分',
                      difficulty: '初級',
                      category: 'デザート',
                      ingredients: [
                        RecipeIngredient(name: '小麦粉', amount: '150g'),
                        RecipeIngredient(name: '卵', amount: '1個'),
                        RecipeIngredient(name: '牛乳', amount: '150ml'),
                        RecipeIngredient(name: '砂糖', amount: '30g'),
                        RecipeIngredient(name: 'ベーキングパウダー', amount: '小さじ1'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '材料を混ぜる',
                          description:
                              'ボウルに卵と砂糖を入れて混ぜ、牛乳、小麦粉、ベーキングパウダーを加えてよく混ぜる。',
                        ),
                        RecipeStep(
                          title: '焼く',
                          description: 'フライパンに生地を流し入れ、弱火で両面を焼く。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'マルゲリータピザ',
                      description: 'シンプルで美味しいイタリアンクラシック',
                      icon: '🍕',
                      backgroundColor: const Color(0xFFFFEDD8),
                      imagePath: '',
                      time: '30分',
                      servings: '2人分',
                      difficulty: '中級',
                      category: 'メイン料理',
                      ingredients: [
                        RecipeIngredient(name: 'ピザ生地', amount: '1枚'),
                        RecipeIngredient(name: 'トマトソース', amount: '50g'),
                        RecipeIngredient(name: 'モッツァレラチーズ', amount: '80g'),
                        RecipeIngredient(name: 'バジル', amount: '適量'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '生地にソースを塗る',
                          description: 'ピザ生地にトマトソースを塗る。',
                        ),
                        RecipeStep(
                          title: '具材をのせる',
                          description: 'チーズとバジルをのせる。',
                        ),
                        RecipeStep(
                          title: '焼く',
                          description: 'オーブンで焼き色がつくまで焼く。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'サラダ',
                      description: '新鮮でヘルシーな一品',
                      icon: '🥗',
                      backgroundColor: const Color(0xFFE8FFF0),
                      imagePath: '',
                      time: '10分',
                      servings: '2人分',
                      difficulty: '初級',
                      category: '副菜',
                      ingredients: [
                        RecipeIngredient(name: 'レタス', amount: '1/2玉'),
                        RecipeIngredient(name: 'トマト', amount: '1個'),
                        RecipeIngredient(name: 'きゅうり', amount: '1本'),
                        RecipeIngredient(name: 'ドレッシング', amount: '適量'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '野菜を切る',
                          description: 'レタス、トマト、きゅうりを食べやすい大きさに切る。',
                        ),
                        RecipeStep(
                          title: '盛り付ける',
                          description: '器に盛り付けてドレッシングをかける。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'スープ',
                      description: 'あったかいスープでほっこり',
                      icon: '🍲',
                      backgroundColor: const Color(0xFFFFF3E8),
                      imagePath: '',
                      time: '25分',
                      servings: '3人分',
                      difficulty: '初級',
                      category: '副菜',
                      ingredients: [
                        RecipeIngredient(name: '玉ねぎ', amount: '1個'),
                        RecipeIngredient(name: 'にんじん', amount: '1本'),
                        RecipeIngredient(name: 'じゃがいも', amount: '2個'),
                        RecipeIngredient(name: 'コンソメ', amount: '1個'),
                        RecipeIngredient(name: '水', amount: '600ml'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '野菜を切る',
                          description: '玉ねぎ、にんじん、じゃがいもを食べやすい大きさに切る。',
                        ),
                        RecipeStep(
                          title: '煮込む',
                          description: '鍋に水と野菜、コンソメを入れて柔らかくなるまで煮込む。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'オムレツ',
                      description: 'ふわとろの朝食メニュー',
                      icon: '🍳',
                      backgroundColor: const Color(0xFFFFF0F5),
                      imagePath: '',
                      time: '15分',
                      servings: '2人分',
                      difficulty: '初級',
                      category: '朝食',
                      ingredients: [
                        RecipeIngredient(name: '卵', amount: '2個'),
                        RecipeIngredient(name: '牛乳', amount: '30ml'),
                        RecipeIngredient(name: '塩・こしょう', amount: '適量'),
                        RecipeIngredient(name: 'バター', amount: '10g'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '材料を混ぜる',
                          description: '卵、牛乳、塩こしょうを混ぜる。',
                        ),
                        RecipeStep(
                          title: '焼く',
                          description: 'フライパンにバターを熱し、卵液を流し入れて焼く。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'パスタ',
                      description: '簡単で美味しいイタリアン',
                      icon: '🍝',
                      backgroundColor: const Color(0xFFFFF7E6),
                      imagePath: '',
                      time: '25分',
                      servings: '2人分',
                      difficulty: '初級',
                      category: 'メイン料理',
                      ingredients: [
                        RecipeIngredient(name: 'パスタ', amount: '200g'),
                        RecipeIngredient(name: 'トマトソース', amount: '100g'),
                        RecipeIngredient(name: '塩', amount: '適量'),
                        RecipeIngredient(name: 'オリーブオイル', amount: '大さじ1'),
                      ],
                      steps: [
                        RecipeStep(
                          title: 'パスタを茹でる',
                          description: '鍋に湯を沸かし、塩を加えてパスタを茹でる。',
                        ),
                        RecipeStep(
                          title: 'ソースを作る',
                          description: 'フライパンでトマトソースとオリーブオイルを温める。',
                        ),
                        RecipeStep(
                          title: '和える',
                          description: '茹でたパスタとソースを和える。',
                        ),
                      ],
                    ),
                    RecipeCardItem(
                      title: 'アイス',
                      description: 'デザートにぴったり',
                      icon: '🍨',
                      backgroundColor: const Color(0xFFEFE8FF),
                      imagePath: '',
                      time: '5分',
                      servings: '1人分',
                      difficulty: '初級',
                      category: 'デザート',
                      ingredients: [
                        RecipeIngredient(name: 'アイスクリーム', amount: '適量'),
                        RecipeIngredient(name: 'トッピング', amount: '適量'),
                      ],
                      steps: [
                        RecipeStep(
                          title: '盛り付ける',
                          description: '器にアイスクリームを盛り付け、トッピングを加える。',
                        ),
                      ],
                    ),
                  ],
                  desiredItemWidth: 200.0,
                  height: 200.0,
                  onCardTap: (recipe) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(recipe: recipe),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // TODO: Barにする
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddRecipeDialog(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('レシピを追加する'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         '検索履歴',
          //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //       ),
          //       const SizedBox(height: 8),
          //       const Text(
          //         '検索したレシピ',
          //         style: TextStyle(color: Colors.grey, fontSize: 14),
          //       ),
          //       const SizedBox(height: 16),
          //       // ページ遷移ボタン付きの横ページ表示ウィジェット
          //       SizedBox(
          //         height: 200,
          //         child: PageHorizontalList(
          //           items: [
          //             RecipeCardItem(
          //               title: 'チキンカレー',
          //               description: 'スパイシーで濃厚な本格カレー',
          //               icon: '🍛',
          //               backgroundColor: const Color(0xFFFFECDD),
          //               imagePath: '',
          //               time: '45分',
          //               servings: '4人分',
          //               difficulty: '中級',
          //               category: 'メイン料理',
          //               ingredients: [
          //                 RecipeIngredient(name: '鶏もも肉（一口大に切る）', amount: '400g'),
          //                 RecipeIngredient(name: '玉ねぎ（薄切り）', amount: '2個'),
          //                 RecipeIngredient(name: 'カレールー', amount: '1箱'),
          //                 RecipeIngredient(name: '水', amount: '800ml'),
          //                 RecipeIngredient(name: 'サラダ油', amount: '大さじ2'),
          //                 RecipeIngredient(name: '塩・こしょう', amount: '適量'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '材料を準備する',
          //                   description:
          //                       '鶏もも肉を一口大に切り、玉ねぎを薄切りにする。塩こしょうで鶏肉に下味をつける。',
          //                 ),
          //                 RecipeStep(
          //                   title: '鶏肉を炒める',
          //                   description: 'フライパンにサラダ油を熱し、鶏肉を入れて表面に焼き色がつくまで炒める。',
          //                 ),
          //                 RecipeStep(
          //                   title: '玉ねぎを加える',
          //                   description: '玉ねぎを加えてしんなりするまで炒める。透明感が出てきたらOK。',
          //                 ),
          //                 RecipeStep(
          //                   title: '煮込む',
          //                   description: '水を加えて沸騰させ、アクを取りながら20分程度煮込む。',
          //                 ),
          //                 RecipeStep(
          //                   title: 'カレールーを加える',
          //                   description:
          //                       '一度火を止めてカレールーを加え、よく溶かしてから再び弱火で10分煮込んで完成。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'パンケーキ',
          //               description: 'ふわふわで美味しい朝食の定番',
          //               icon: '☕',
          //               backgroundColor: const Color(0xFFF8E8FF),
          //               imagePath: '',
          //               time: '20分',
          //               servings: '2人分',
          //               difficulty: '初級',
          //               category: 'デザート',
          //               ingredients: [
          //                 RecipeIngredient(name: '小麦粉', amount: '150g'),
          //                 RecipeIngredient(name: '卵', amount: '1個'),
          //                 RecipeIngredient(name: '牛乳', amount: '150ml'),
          //                 RecipeIngredient(name: '砂糖', amount: '30g'),
          //                 RecipeIngredient(name: 'ベーキングパウダー', amount: '小さじ1'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '材料を混ぜる',
          //                   description:
          //                       'ボウルに卵と砂糖を入れて混ぜ、牛乳、小麦粉、ベーキングパウダーを加えてよく混ぜる。',
          //                 ),
          //                 RecipeStep(
          //                   title: '焼く',
          //                   description: 'フライパンに生地を流し入れ、弱火で両面を焼く。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'マルゲリータピザ',
          //               description: 'シンプルで美味しいイタリアンクラシック',
          //               icon: '🍕',
          //               backgroundColor: const Color(0xFFFFEDD8),
          //               imagePath: '',
          //               time: '30分',
          //               servings: '2人分',
          //               difficulty: '中級',
          //               category: 'メイン料理',
          //               ingredients: [
          //                 RecipeIngredient(name: 'ピザ生地', amount: '1枚'),
          //                 RecipeIngredient(name: 'トマトソース', amount: '50g'),
          //                 RecipeIngredient(name: 'モッツァレラチーズ', amount: '80g'),
          //                 RecipeIngredient(name: 'バジル', amount: '適量'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '生地にソースを塗る',
          //                   description: 'ピザ生地にトマトソースを塗る。',
          //                 ),
          //                 RecipeStep(
          //                   title: '具材をのせる',
          //                   description: 'チーズとバジルをのせる。',
          //                 ),
          //                 RecipeStep(
          //                   title: '焼く',
          //                   description: 'オーブンで焼き色がつくまで焼く。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'サラダ',
          //               description: '新鮮でヘルシーな一品',
          //               icon: '🥗',
          //               backgroundColor: const Color(0xFFE8FFF0),
          //               imagePath: '',
          //               time: '10分',
          //               servings: '2人分',
          //               difficulty: '初級',
          //               category: '副菜',
          //               ingredients: [
          //                 RecipeIngredient(name: 'レタス', amount: '1/2玉'),
          //                 RecipeIngredient(name: 'トマト', amount: '1個'),
          //                 RecipeIngredient(name: 'きゅうり', amount: '1本'),
          //                 RecipeIngredient(name: 'ドレッシング', amount: '適量'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '野菜を切る',
          //                   description: 'レタス、トマト、きゅうりを食べやすい大きさに切る。',
          //                 ),
          //                 RecipeStep(
          //                   title: '盛り付ける',
          //                   description: '器に盛り付けてドレッシングをかける。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'スープ',
          //               description: 'あったかいスープでほっこり',
          //               icon: '🍲',
          //               backgroundColor: const Color(0xFFFFF3E8),
          //               imagePath: '',
          //               time: '25分',
          //               servings: '3人分',
          //               difficulty: '初級',
          //               category: '副菜',
          //               ingredients: [
          //                 RecipeIngredient(name: '玉ねぎ', amount: '1個'),
          //                 RecipeIngredient(name: 'にんじん', amount: '1本'),
          //                 RecipeIngredient(name: 'じゃがいも', amount: '2個'),
          //                 RecipeIngredient(name: 'コンソメ', amount: '1個'),
          //                 RecipeIngredient(name: '水', amount: '600ml'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '野菜を切る',
          //                   description: '玉ねぎ、にんじん、じゃがいもを食べやすい大きさに切る。',
          //                 ),
          //                 RecipeStep(
          //                   title: '煮込む',
          //                   description: '鍋に水と野菜、コンソメを入れて柔らかくなるまで煮込む。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'オムレツ',
          //               description: 'ふわとろの朝食メニュー',
          //               icon: '🍳',
          //               backgroundColor: const Color(0xFFFFF0F5),
          //               imagePath: '',
          //               time: '15分',
          //               servings: '2人分',
          //               difficulty: '初級',
          //               category: '朝食',
          //               ingredients: [
          //                 RecipeIngredient(name: '卵', amount: '2個'),
          //                 RecipeIngredient(name: '牛乳', amount: '30ml'),
          //                 RecipeIngredient(name: '塩・こしょう', amount: '適量'),
          //                 RecipeIngredient(name: 'バター', amount: '10g'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '材料を混ぜる',
          //                   description: '卵、牛乳、塩こしょうを混ぜる。',
          //                 ),
          //                 RecipeStep(
          //                   title: '焼く',
          //                   description: 'フライパンにバターを熱し、卵液を流し入れて焼く。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'パスタ',
          //               description: '簡単で美味しいイタリアン',
          //               icon: '🍝',
          //               backgroundColor: const Color(0xFFFFF7E6),
          //               imagePath: '',
          //               time: '25分',
          //               servings: '2人分',
          //               difficulty: '初級',
          //               category: 'メイン料理',
          //               ingredients: [
          //                 RecipeIngredient(name: 'パスタ', amount: '200g'),
          //                 RecipeIngredient(name: 'トマトソース', amount: '100g'),
          //                 RecipeIngredient(name: '塩', amount: '適量'),
          //                 RecipeIngredient(name: 'オリーブオイル', amount: '大さじ1'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: 'パスタを茹でる',
          //                   description: '鍋に湯を沸かし、塩を加えてパスタを茹でる。',
          //                 ),
          //                 RecipeStep(
          //                   title: 'ソースを作る',
          //                   description: 'フライパンでトマトソースとオリーブオイルを温める。',
          //                 ),
          //                 RecipeStep(
          //                   title: '和える',
          //                   description: '茹でたパスタとソースを和える。',
          //                 ),
          //               ],
          //             ),
          //             RecipeCardItem(
          //               title: 'アイス',
          //               description: 'デザートにぴったり',
          //               icon: '🍨',
          //               backgroundColor: const Color(0xFFEFE8FF),
          //               imagePath: '',
          //               time: '5分',
          //               servings: '1人分',
          //               difficulty: '初級',
          //               category: 'デザート',
          //               ingredients: [
          //                 RecipeIngredient(name: 'アイスクリーム', amount: '適量'),
          //                 RecipeIngredient(name: 'トッピング', amount: '適量'),
          //               ],
          //               steps: [
          //                 RecipeStep(
          //                   title: '盛り付ける',
          //                   description: '器にアイスクリームを盛り付け、トッピングを加える。',
          //                 ),
          //               ],
          //             ),
          //           ],
          //           desiredItemWidth: 200.0,
          //           height: 200.0,
          //         ),
          //       ),
          //       const SizedBox(height: 16),
          //       // TODO: Barにする
          //       Center(
          //         child: ElevatedButton.icon(
          //           onPressed: () {
          //             // TODO: レシピ検索画面へ遷移
          //           },
          //           icon: const Icon(Icons.search),
          //           label: const Text('レシピを検索する'),
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.orangeAccent,
          //             foregroundColor: Colors.white,
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: 24,
          //               vertical: 12,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
