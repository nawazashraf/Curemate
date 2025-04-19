import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:curemate/utils/utils.dart';
import 'package:curemate/lib/Screens/Icon Widget/IconWidget.dart';

class AccountPage extends StatelessWidget {
  static const String keyLanguage = 'key-language';
  static const String keyLocation = 'key-location';

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
    title: 'Account Settings',
    subtitle: 'Privacy, Security, Language',
    leading: IconWidget(icon: Icons.person, color: Colors.green),
    child: SettingsScreen(
      title: 'Account Settings',
      children: <Widget>[
        buildLanguage(),
        buildLocation(),
        buildPassword(context),
        buildPrivacy(context),
        buildSecurity(context),
        buildAccountInfo(context),
      ],
    ),
  );

  Widget buildLanguage() => DropDownSettingsTile(
    settingKey: keyLanguage,
    title: 'Language',
    selected: 1,
    values: <int, String>{
      1: 'English',
      2: 'Spanish',
      3: 'Chinese',
      4: 'Hindi',
    },
    onChange: (language) {},
  );

  Widget buildLocation() => TextInputSettingsTile(
    settingKey: keyLocation,
    title: 'Location',
    initialValue: 'India',
    onChange: (location) {},
  );

  Widget buildPassword(BuildContext context) => SimpleSettingsTile(
    title: 'Password',
    subtitle: '••••••',
    leading: IconWidget(icon: Icons.password, color: Colors.orange),
    onTap: () => Utils.showSnackBar(context, 'Clicked Password'),
  );

  Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
    title: 'Privacy',
    subtitle: '',
    leading: IconWidget(icon: Icons.lock, color: Colors.blue),
    onTap: () => Utils.showSnackBar(context, 'Clicked Privacy'),
  );

  Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
    title: 'Security',
    subtitle: '',
    leading: IconWidget(icon: Icons.security, color: Colors.red),
    onTap: () => Utils.showSnackBar(context, 'Clicked Security'),
  );

  Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
    title: 'Account Info',
    subtitle: '',
    leading: IconWidget(icon: Icons.text_snippet, color: Colors.purple),
    onTap: () => Utils.showSnackBar(context, 'Clicked Account Info'),
  );
}
