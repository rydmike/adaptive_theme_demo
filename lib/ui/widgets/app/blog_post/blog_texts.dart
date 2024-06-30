sealed class BlogTexts {
  static const String blogHeading1 = 'Expressive Material 3';
  static const String blogContent1 = '''
Google’s new Material 3 design is a design system that aims to create beautiful and expressive themes that reflect the user’s personal preferences and context. Material 3 design introduces new features and tools that enable designers and developers to customize the appearance and behavior of their apps, such as color, typography, shape, motion, and dark theme1.

One of the main features of Material 3 design is the dynamic color system, which allows apps to generate color palettes based on the user’s wallpaper, system settings, or custom inputs. The color system also adapts to different lighting conditions and modes, such as dark theme or high contrast mode1. This way, apps can create themes that are more harmonious, vibrant, and personal for each user.

Another feature of Material 3 design is the new component library, which provides a set of flexible and adaptable components that can be used across different platforms and devices. The components are designed to support various types of interactions, such as touch, mouse, keyboard, and voice. The components also follow the principles of Material Design, such as responsiveness, clarity, and consistency2.
''';

  static const String blogHeading2 = 'Surface Roles';
  static const String blogContent2 = '''
New surface color roles offer more flexibility for large screens and rich color features

The previous way makers could achieve tinted surfaces, which are a hallmark of the M3 design language, was to assign the color role “surface” to a component, and increase its elevation to achieve the desired tinting which was applied via an opacity layer.

The update introduces dedicated surface color roles that are no longer tied to elevation. Makers will be able to choose the right surface roles based on the containment needs of their products, and now have more layout flexibility for larger screens.
''';
}
