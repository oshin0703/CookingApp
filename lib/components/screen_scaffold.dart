import 'package:app/components/basic_page.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({super.key, required this.body, String? barTitle})
    : barTitle = barTitle ?? 'Cooking App';

  final Widget body;
  final String barTitle;

  @override
  Widget build(BuildContext context) {
    final title = Row(
      children: [
        IconButton(
          onPressed: () {
            BasicPage.replace(context, const HomePage());
          },
          icon: Image.asset('assets/icons/home_icon.png'),
        ),
        const SizedBox(width: 8),
        Text(barTitle),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: title,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            height: 2, //高さ
            color: Colors.black, //色
          ),
        ), //高さ
      ),
      body: body,
    );
  }
}
