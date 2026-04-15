import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:orda/features/user/presentation/widgets/general_section.dart';
import 'package:orda/features/user/presentation/widgets/preferences_section.dart';
import 'package:orda/features/user/presentation/widgets/profile_section.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: 16,
              children: [
                ProfileSection(),
                GeneralSection(),
                PreferencesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
