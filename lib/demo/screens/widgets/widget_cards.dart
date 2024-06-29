import 'package:flutter/material.dart';

import '../../../shared/widgets/app/show_color_scheme_colors.dart';
import '../../../shared/widgets/app/show_sub_theme_colors.dart';
import '../../../shared/widgets/app/show_theme_data_colors.dart';
import '../../../shared/widgets/universal/showcase_material.dart';
import '../../../shared/widgets/universal/stateful_header_card.dart';

class ShowColorScheme extends StatelessWidget {
  const ShowColorScheme({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.palette_outlined),
      title: Text('Colors'),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ShowColorSchemeColors(),
            ShowThemeDataColors(),
            ShowSubThemeColors(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ButtonsSwitchesIconsShow extends StatelessWidget {
  const ButtonsSwitchesIconsShow({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(fontSize: 16);
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.crop_16_9_outlined),
      title: Text('Buttons, Switches and Icons'),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // Buttons
            //
            Text('Material Buttons', style: headerStyle),
            SizedBox(height: 8),
            ElevatedButtonShowcase(),
            SizedBox(height: 8),
            FilledButtonShowcase(),
            SizedBox(height: 8),
            FilledButtonTonalShowcase(),
            SizedBox(height: 8),
            OutlinedButtonShowcase(),
            SizedBox(height: 8),
            TextButtonShowcase(),
            SizedBox(height: 16),
            //
            // ToggleButtons and SegmentedButton
            //
            Text('ToggleButtons and SegmentedButton', style: headerStyle),
            SizedBox(height: 8),
            ToggleButtonsShowcase(compareButtons: true),
            SizedBox(height: 8),
            SegmentedButtonShowcase(),
            SizedBox(height: 16),
            //
            // FloatingActionButton and Chip
            //
            Text('FloatingActionButton and Chip', style: headerStyle),
            SizedBox(height: 8),
            FabShowcase(),
            SizedBox(height: 16),
            ChipShowcase(),
            SizedBox(height: 16),
            //
            // Switch, CheckBox and Radio
            //
            Text('Switch, CheckBox and Radio', style: headerStyle),
            SizedBox(height: 8),
            SwitchShowcase(showCupertinoSwitches: true),
            CheckboxShowcase(),
            RadioShowcase(),
            SizedBox(height: 8),
            //
            // Icon
            //
            Text('Icon', style: headerStyle),
            SizedBox(height: 16),
            IconShowcase(),
            SizedBox(height: 16),
            //
            // IconButton
            //
            Text('IconButton', style: headerStyle),
            SizedBox(height: 16),
            IconButtonShowcase(),
            SizedBox(height: 16),
            IconButtonVariantsShowcase(),
            SizedBox(height: 16),
            //
            // CircleAvatar
            //
            Text('CircleAvatar', style: headerStyle),
            SizedBox(height: 16),
            CircleAvatarShowcase(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ToggleFabSwitchesChipsShow extends StatelessWidget {
  const ToggleFabSwitchesChipsShow({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(fontSize: 16);
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.tune),
      title: Text('Tooltips, Progress Indicators and Sliders'),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // Tooltip
            //
            Text('Tooltip', style: headerStyle),
            SizedBox(height: 8),
            TooltipShowcase(),
            SizedBox(height: 16),
            //
            // ProgressIndicator
            //
            Text('ProgressIndicator', style: headerStyle),
            SizedBox(height: 8),
            ProgressIndicatorShowcase(),
            SizedBox(height: 16),
            //
            // Slider and RangeSlider
            //
            Text('Slider and RangeSlider', style: headerStyle),
            SizedBox(height: 8),
            SliderShowcase(),
            Divider(),
            RangeSliderShowcase(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class TextInputFieldShow extends StatelessWidget {
  const TextInputFieldShow({super.key});
  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(fontSize: 16);

    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.pin_outlined),
      title: Text('TextFields and Menus'),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // TextField
            //
            Text('TextField with InputDecorator', style: headerStyle),
            SizedBox(height: 8),
            TextFieldShowcase(),
            SizedBox(height: 16),
            //
            // PopupMenuButton, DropdownButtonFormField, DropDownButton
            //
            Text('PopupMenuButton and DropdownButtons', style: headerStyle),
            PopupMenuButtonsShowcase(explain: true),
            SizedBox(height: 8),
            DropdownButtonFormFieldShowcase(explain: true),
            SizedBox(height: 8),
            //
            // DropdownMenu, MenuBar, MenuAnchor
            //
            Text('Dropdown Menus and MenuBar', style: headerStyle),
            DropDownMenuShowcase(explain: true),
            MenuAnchorShowcase(explain: true),
            MenuBarShowcase(explain: true),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class AppTabBottomSearch extends StatelessWidget {
  const AppTabBottomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(fontSize: 16);
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.tab_outlined),
      title: Text('AppBar TabBar BottomAppBar and SearchBar'),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // AppBars and TabBar
            //
            Text('AppBar and TabBar', style: headerStyle),
            SizedBox(height: 8),
            AppBarShowcase(),
            SizedBox(height: 8),
            TabBarForAppBarShowcase(explain: true),
            SizedBox(height: 8),
            TabBarForBackgroundShowcase(explain: true),
            SizedBox(height: 32),
            //
            // BottomAppBar and SearchBar
            //
            Text('BottomAppBar and SearchBar', style: headerStyle),
            BottomAppBarShowcase(explain: true),
            SearchBarShowcase(explain: true),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBarsShow extends StatelessWidget {
  const BottomNavigationBarsShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.video_label),
      title: Text('Bottom Navigation'),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BottomNavigationBarShowcase(explain: true),
            SizedBox(height: 8),
            NavigationBarShowcase(explain: true),
          ],
        ),
      ),
    );
  }
}

class NavigationRailShow extends StatelessWidget {
  const NavigationRailShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.view_sidebar_outlined),
      title: Text('NavigationRail'),
      child: NavigationRailShowcase(explain: true),
    );
  }
}

class NavigationDrawerShow extends StatelessWidget {
  const NavigationDrawerShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.featured_video_outlined),
      title: Text('NavigationDrawer'),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NavigationDrawerShowcase(explain: true),
            DrawerShowcase(explain: true),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class DialogShow extends StatelessWidget {
  const DialogShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.branding_watermark_outlined),
      title: Text('Dialogs'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //
          // AlertDialog, TimePickerDialog, DatePickerDialog
          //
          SizedBox(height: 8),
          AlertDialogShowcase(),
          SizedBox(height: 8),
          TimePickerDialogShowcase(),
          SizedBox(height: 8),
          DatePickerDialogShowcase(),
        ],
      ),
    );
  }
}

class BottomSheetSnackBannerShow extends StatelessWidget {
  const BottomSheetSnackBannerShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.call_to_action_outlined),
      title: Text('BottomSheet, SnackBar and Banner'),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // BottomSheet
            //
            SizedBox(height: 16),
            BottomSheetShowcase(),
            SizedBox(height: 16),
            BottomSheetModalShowcase(),
            SizedBox(height: 16),
            //
            // SnackBar and MaterialBanner
            //
            SizedBox(height: 8),
            MaterialBannerSnackBarShowcase(),
          ],
        ),
      ),
    );
  }
}

class CardsShow extends StatelessWidget {
  const CardsShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
        isOpen: false,
        leading: Icon(Icons.picture_in_picture_alt_outlined),
        title: Text('Card'),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //
              // Card
              //
              SizedBox(height: 8),
              CardShowcase(explain: true),
              SizedBox(height: 16),
            ],
          ),
        ));
  }
}

class ListTileShow extends StatelessWidget {
  const ListTileShow({super.key});
  @override
  Widget build(BuildContext context) {
    return const StatefulHeaderCard(
      isOpen: false,
      leading: Icon(Icons.dns_outlined),
      title: Text('ListTiles'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTileShowcase(),
          Divider(height: 1),
          SwitchListTileShowcase(),
          Divider(height: 1),
          CheckboxListTileShowcase(),
          Divider(height: 1),
          RadioListTileShowcase(),
          Divider(),
          ExpansionTileShowcase(),
          Divider(),
          ExpansionPanelListShowcase(),
        ],
      ),
    );
  }
}

class TextThemeShow extends StatefulWidget {
  const TextThemeShow({super.key});

  @override
  State<TextThemeShow> createState() => _TextThemeShowState();
}

class _TextThemeShowState extends State<TextThemeShow> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return StatefulHeaderCard(
      isOpen: false,
      leading: const Icon(Icons.font_download_outlined),
      title: const Text('TextTheme'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Show text style details'),
            value: showDetails,
            onChanged: (bool value) {
              setState(() {
                showDetails = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextThemeShowcase(showDetails: showDetails),
          ),
        ],
      ),
    );
  }
}

class PrimaryTextThemeShow extends StatefulWidget {
  const PrimaryTextThemeShow({super.key});

  @override
  State<PrimaryTextThemeShow> createState() => _PrimaryTextThemeShowState();
}

class _PrimaryTextThemeShowState extends State<PrimaryTextThemeShow> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return StatefulHeaderCard(
      isOpen: false,
      leading: const Icon(Icons.font_download),
      title: const Text('PrimaryTextTheme'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Show text style details'),
            value: showDetails,
            onChanged: (bool value) {
              setState(() {
                showDetails = value;
              });
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: PrimaryTextThemeShowcase(showDetails: showDetails),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
