import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import '../Icon Widget/IconWidget.dart';
import 'package:curemate/utils/utils.dart';
import 'AccountPage.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            // User profile section at the top
            _buildUserProfile(),
            const SizedBox(height: 24),
            SettingsGroup(
              title: 'General',
              children: <Widget>[
                const SizedBox(height: 8),
                AccountPage(),
                buildLogout(context),
                buildDeleteAccount(context),
              ],
            ),
            const SizedBox(height: 32),
            SettingsGroup(
              title: 'Feedback',
              children: <Widget>[
                const SizedBox(height: 8),
                buildReportBug(context),
                buildSendFeedback(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // User profile section widget
  Widget _buildUserProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile picture
          CircleAvatar(
            radius: 40,  // Adjust size as needed
            backgroundImage: AssetImage('assets/images/apple.png'),
          ),
          const SizedBox(width: 16),
          // User info (name and userID)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Khurshid Ansari',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'khurshidbhay@123',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Logout tile
Widget buildLogout(BuildContext context) => SimpleSettingsTile(
  title: 'Logout',
  subtitle: '',
  leading: IconWidget(
    icon: Icons.logout,
    color: Colors.blueAccent,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Logout'),
);

// Delete Account tile
Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
  title: 'Delete Account',
  subtitle: '',
  leading: IconWidget(
    icon: Icons.delete,
    color: Colors.pink,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Delete Account'),
);

// Report Bug tile
Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
  title: 'Report a Bug',
  subtitle: '',
  leading: IconWidget(
    icon: Icons.report,
    color: Colors.teal,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Report a Bug'),
);

// Send Feedback tile (updated icon)
Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
  title: 'Send Feedback',
  subtitle: '',
  leading: IconWidget(
    icon: Icons.feedback,  // Updated icon
    color: Colors.purple,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Send Feedback'),
);
