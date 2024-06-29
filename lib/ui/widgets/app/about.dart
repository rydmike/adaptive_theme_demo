import 'package:flutter/material.dart';

import '../../../shared/const/app.dart';
import '../../../shared/utils/link_text_span.dart';

/// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key, this.color, this.useRootNavigator = true});

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  /// Use root navigator?
  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info, color: color),
      onPressed: () {
        showAppAboutDialog(context, useRootNavigator);
      },
    );
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(BuildContext context, [bool useRootNavigator = true]) {
  final ThemeData theme = Theme.of(context);
  final TextStyle aboutTextStyle = theme.textTheme.bodyMedium!;
  final TextStyle footerStyle = theme.textTheme.bodySmall!;
  final TextStyle linkStyle =
      theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary);

  final Size mediaSize = MediaQuery.sizeOf(context);
  final double width = mediaSize.width;
  final double height = mediaSize.height;

  showAboutDialog(
    context: context,
    applicationName: App.title(context),
    applicationVersion: App.version,
    useRootNavigator: useRootNavigator,
    applicationIcon: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.info,
          size: 50,
          color: theme.colorScheme.primary,
        ),
      ],
    ),
    applicationLegalese: '${App.copyright}\n${App.author}\n${App.license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'The ${App.title(context)} app is used in a talk about '
                    'Material design and shows adaptive '
                    'theming in Flutter. It uses a fictive ${App.company} '
                    'company and their theming requirements.\n\n'
                    'Advanced ColorScheme generation is demonstrated '
                    'using package ',
              ),
              LinkTextSpan(
                style: linkStyle,
                uri: App.packageUri,
                text: 'FlexSeedScheme',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: ' for seeded ColorScheme generation.\n\n',
              ),
              TextSpan(
                style: footerStyle,
                text: 'Built with Flutter ${App.flutterVersion}\n'
                    'Media size (w:${width.toStringAsFixed(0)}, '
                    'h:${height.toStringAsFixed(0)})\n\n',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
