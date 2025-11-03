import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/recipe_card_item.dart';

class PageHorizontalList extends StatefulWidget {
  final List<RecipeCardItem> items;
  final double desiredItemWidth;
  final double height;
  final double spacing;
  final double buttonWidth;
  final void Function(RecipeCardItem)? onCardTap;

  const PageHorizontalList({
    super.key,
    required this.items,
    this.desiredItemWidth = 200.0,
    this.height = 200.0,
    this.spacing = 16.0,
    this.buttonWidth = 48.0,
    this.onCardTap,
  });

  @override
  State<PageHorizontalList> createState() => _PageHorizontalListState();
}

class _PageHorizontalListState extends State<PageHorizontalList> {
  final PageController _controller = PageController(viewportFraction: 1.0);
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final desiredItemWidth = widget.desiredItemWidth;
    final spacing = widget.spacing;
    final buttonWidth = widget.buttonWidth;
    final height = widget.height;

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth - buttonWidth * 2 - 8.0;
          final possibleVisible =
              ((availableWidth + spacing) / (desiredItemWidth + spacing))
                  .floor();
          final visibleCount = math.max(1, possibleVisible);
          final totalSpacing = spacing * (visibleCount - 1);
          final itemWidth = (availableWidth - totalSpacing) / visibleCount;
          final pageCount = (items.length / visibleCount).ceil();

          return Row(
            children: [
              SizedBox(
                width: buttonWidth,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _currentPage > 0
                      ? () {
                          final prev = (_currentPage - 1).clamp(
                            0,
                            pageCount - 1,
                          );
                          _controller.animateToPage(
                            prev,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pageCount,
                  onPageChanged: (p) => setState(() => _currentPage = p),
                  itemBuilder: (context, pageIndex) {
                    final start = pageIndex * visibleCount;
                    final end = (start + visibleCount).clamp(0, items.length);
                    final pageItems = items.sublist(start, end);

                    return Row(
                      children: List.generate(visibleCount * 2 - 1, (i) {
                        if (i.isOdd) return SizedBox(width: spacing);
                        final itemIndex = i ~/ 2;
                        if (itemIndex < pageItems.length) {
                          final r = pageItems[itemIndex];
                          return SizedBox(
                            width: itemWidth,
                            child: GestureDetector(
                              onTap: widget.onCardTap != null
                                  ? () => widget.onCardTap!(r)
                                  : null,
                              child: _buildCard(
                                title: r.title,
                                description: r.description,
                                icon: r.icon,
                                backgroundColor: r.backgroundColor,
                              ),
                            ),
                          );
                        }
                        return SizedBox(width: itemWidth);
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: buttonWidth,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _currentPage < pageCount - 1
                      ? () {
                          final next = (_currentPage + 1).clamp(
                            0,
                            pageCount - 1,
                          );
                          _controller.animateToPage(
                            next,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
    required String icon,
    required Color backgroundColor,
  }) {
    return Card(
      color: backgroundColor,
      elevation: 0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(icon, style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
