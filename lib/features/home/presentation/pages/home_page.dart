import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/home/presentation/widgets/today_overview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: context.colors.secondaryContainer,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(
            'Orda xin chào ✌️',
            style: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onSecondaryContainer,
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          IconButton.filledTonal(
            onPressed: () => context.push(AppRouter.scan),
            style: IconButton.styleFrom(padding: EdgeInsets.zero),
            icon: Icon(
              Iconsax.scan_barcode_copy,
              color: context.colors.onSecondaryContainer,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              const TodayOverview(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  Text(
                    'Thống kê',
                    style: context.textTheme.bodyLarge,
                  ),

                  /// Chart
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
