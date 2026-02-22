import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.body,
    this.barTitle,
    this.titleWidget,
    this.leading,
    this.actions,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.bottomBorder = true,
  });

  final Widget body;
  final String? barTitle;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: titleWidget ??
            (barTitle != null
                ? Text(
                    barTitle!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )
                : null),
        leading: leading,
        leadingWidth: leading != null ? 100 : null,
        actions: actions,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: bottomBorder
            ? PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              )
            : null,
      ),
      body: body,
    );
  }
}
