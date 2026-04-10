import 'package:flutter/material.dart';
import 'package:orda/features/user/presentation/widgets/general_section.dart';
import 'package:orda/features/user/presentation/widgets/preferences_section.dart';
import 'package:orda/features/user/presentation/widgets/profile_section.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ người dùng')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ProfileSection(),
              GeneralSection(),
              PreferencesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
