import 'package:flutter/material.dart';

import '../../../../theme/app_theme_extension.dart';
import '../../universal/stateful_header_card.dart';

@immutable
class BlogPostCard extends StatelessWidget {
  const BlogPostCard({
    super.key,
    required this.cardHeading,
    required this.blogHeading,
    required this.blogContent,
  });
  final String cardHeading;
  final String blogHeading;
  final String blogContent;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StatefulHeaderCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: const Icon(Icons.text_snippet_outlined),
      title: Text(cardHeading),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                blogHeading,
                style: theme.extension<AppThemeExtension>()?.blogHeader ??
                    theme.textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                blogContent,
                style: theme.extension<AppThemeExtension>()?.blogBody ??
                    theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
