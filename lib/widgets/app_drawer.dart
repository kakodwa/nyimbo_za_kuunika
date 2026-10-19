import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  static const String airtelMoneyPhone = "0993344416";
  static const String mpambaPhone = "0882935706";
  static const String developerEmail = "ikpixels.py@gmail.com";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: [
          // Drawer Header with ZEC Branding & Colors
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.zecBlue, AppTheme.zecDarkBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.menu_book_rounded,
                    color: AppTheme.zecBlue,
                    size: 36,
                  ),
                ),
              ),
            ),
            accountName: const Text(
              'NYIMBO ZA KUUNIKA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
            accountEmail: const Text(
              'Zambezi Evangelical Church (Mitsidi Synod)',
              style: TextStyle(
                color: AppTheme.zecGold,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Drawer Navigation Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline, color: AppTheme.zecBlue),
                  title: const Text('About App'),
                  onTap: () {
                    Navigator.pop(context);
                    _showAboutDialog(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.volunteer_activism, color: AppTheme.zecGold),
                  title: const Text('Support Developer'),
                  subtitle: const Text('Help keep the app free'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSupportDialog(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback_outlined, color: AppTheme.zecBlue),
                  title: const Text('Send Feedback'),
                  subtitle: const Text('SMS / WhatsApp / Email'),
                  onTap: () {
                    Navigator.pop(context);
                    _showFeedbackDialog(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined, color: AppTheme.zecBlue),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    Navigator.pop(context);
                    _showPrivacyDialog(context);
                  },
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  secondary: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: AppTheme.zecGold,
                  ),
                  value: themeProvider.isDarkMode,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ],
            ),
          ),

          // Footer Branding
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).cardColor,
            width: double.infinity,
            child: const Column(
              children: [
                Text(
                  'IK-Pixels Tech',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppTheme.zecBlue,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Developed by Isaac Kakodwa',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- DIALOG 1: ABOUT APP ---
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.church,
                  color: AppTheme.zecBlue,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'About Nyimbo za Kuunika',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Owner & Publisher:',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.zecBlue),
              ),
              Text('Zambezi Evangelical Church (Mitsidi Synod)'),
              SizedBox(height: 12),
              Text(
                'Developer:',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.zecBlue),
              ),
              Text('Isaac Kakodwa (Member of ZEC)'),
              Text('IK-Pixels Tech'),
              SizedBox(height: 12),
              Text(
                'Mission:',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.zecBlue),
              ),
              Text(
                'This application was developed voluntarily as an act of service to assist members during church services, choir practices, and personal devotions.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // --- DIALOG 2: SUPPORT DEVELOPER ---
  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.volunteer_activism, color: AppTheme.zecGold),
            SizedBox(width: 8),
            Text('Support Developer', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This app is provided 100% free of charge to the church.',
              ),
              const SizedBox(height: 10),
              const Text(
                'Your voluntary financial support helps us to:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text('• Publish & renew the app on Google Play Store'),
              const Text('• Maintain app performance & fix bugs'),
              const Text('• Add new improvements & features'),
              const Text('• Keep the app free for everyone'),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E7),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppTheme.zecGold),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Support via Mobile Money:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.zecDarkBlue),
                    ),
                    SizedBox(height: 8),
                    SelectableText(
                      'Airtel Money: $airtelMoneyPhone',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.zecBlue),
                    ),
                    SizedBox(height: 4),
                    SelectableText(
                      'TNM Mpamba: $mpambaPhone',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.zecBlue),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Name: Isaac Kakodwa',
                      style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // --- DIALOG 3: SEND FEEDBACK ---
  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.mail_outline, color: AppTheme.zecBlue),
            SizedBox(width: 8),
            Text('Contact & Feedback', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Have suggestions, corrections, or feedback? Feel free to reach out directly to the developer:'),
              SizedBox(height: 14),
              Text('Phone / WhatsApp / SMS:', style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(
                'Airtel: $airtelMoneyPhone\nTNM: $mpambaPhone',
                style: TextStyle(fontSize: 15, color: AppTheme.zecBlue, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(
                developerEmail,
                style: TextStyle(fontSize: 15, color: AppTheme.zecBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // --- DIALOG 4: PRIVACY POLICY ---
  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.privacy_tip, color: AppTheme.zecBlue),
            SizedBox(width: 8),
            Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '1. Data Collection:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('This app does NOT collect, store, or share any personal user data or track your location.'),
              SizedBox(height: 10),
              Text(
                '2. Offline Storage:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('All preferences, favorite hymns, and settings are saved locally on your device only.'),
              SizedBox(height: 10),
              Text(
                '3. Internet Access:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('The app functions completely offline and does not require an active internet connection to read hymns.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}