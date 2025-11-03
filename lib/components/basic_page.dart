import 'package:flutter/material.dart';
import 'screen_scaffold.dart';

// 各ページで共通の Scaffold 構造を提供する抽象クラス
abstract class BasicPage extends StatelessWidget {
  const BasicPage({super.key});

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(barTitle: barTitle, body: buildPage(context));

  // ------------------ Page helpers ------------------

  // アプリ共通の AppBar タイトル
  String get barTitle => 'Cooking App';

  // 各ページ固有のウィジェットを構築するメソッド
  Widget buildPage(BuildContext context);

  // ------------------ Navigation helpers ------------------

  /// push して新しいページに移動する
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.of(
      context,
    ).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// 現在のページを置き換える
  static Future<T?> replace<T, TO>(BuildContext context, Widget page) {
    return Navigator.of(
      context,
    ).pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
  }

  /// 全ての履歴をクリアして新しいページに移動する
  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (_) => false,
    );
  }
}
