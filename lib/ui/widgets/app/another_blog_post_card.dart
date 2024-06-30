import 'package:flutter/material.dart';

import '../../../theme/app_theme_extension.dart';
import '../universal/stateful_header_card.dart';

class AnotherBlogPostCard extends StatelessWidget {
  const AnotherBlogPostCard({super.key});

  static const String _blogText = '''
New surface color roles offer more flexibility for large screens and rich color features

The previous way makers could achieve tinted surfaces, which are a hallmark of the M3 design language, was to assign the color role “surface” to a component, and increase its elevation to achieve the desired tinting which was applied via an opacity layer.

The update introduces dedicated surface color roles that are no longer tied to elevation. Makers will be able to choose the right surface roles based on the containment needs of their products, and now have more layout flexibility for larger screens.
''';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StatefulHeaderCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      isOpen: false,
      leading: const Icon(Icons.text_snippet_outlined),
      title: const Text('Another Blog Example'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Expressive Material 3',
                  style: theme.extension<AppThemeExtension>()?.blogHeader ??
                      theme.textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(_blogText,
                  style: theme.extension<AppThemeExtension>()?.blogBody ??
                      theme.textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
