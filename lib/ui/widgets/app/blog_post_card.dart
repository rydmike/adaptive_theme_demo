import 'package:flutter/material.dart';

import '../../../theme/app_theme_extension.dart';
import '../universal/stateful_header_card.dart';

class BlogPostCard extends StatelessWidget {
  const BlogPostCard({super.key});

  static const String _blogText = '''
Google’s new Material 3 design is a design system that aims to create beautiful and expressive themes that reflect the user’s personal preferences and context. Material 3 design introduces new features and tools that enable designers and developers to customize the appearance and behavior of their apps, such as color, typography, shape, motion, and dark theme1.

One of the main features of Material 3 design is the dynamic color system, which allows apps to generate color palettes based on the user’s wallpaper, system settings, or custom inputs. The color system also adapts to different lighting conditions and modes, such as dark theme or high contrast mode1. This way, apps can create themes that are more harmonious, vibrant, and personal for each user.

Another feature of Material 3 design is the new component library, which provides a set of flexible and adaptable components that can be used across different platforms and devices. The components are designed to support various types of interactions, such as touch, mouse, keyboard, and voice. The components also follow the principles of Material Design, such as responsiveness, clarity, and consistency2.
''';

  @override
  Widget build(BuildContext context) {
    return StatefulHeaderCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      isOpen: false,
      leading: const Icon(Icons.text_snippet_outlined),
      title: const Text('Blog Theme Extension Based'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Blog post card using custom theme extension fonts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Expressive Material 3',
                  style: Theme.of(context)
                      .extension<AppThemeExtension>()
                      ?.blogHeader),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(_blogText,
                  style: Theme.of(context)
                      .extension<AppThemeExtension>()
                      ?.blogBody),
            ),
          ],
        ),
      ),
    );
  }
}
