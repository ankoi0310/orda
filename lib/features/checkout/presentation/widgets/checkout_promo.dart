import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_promo_code_field.dart';

class CheckoutPromo extends StatelessWidget {
  const CheckoutPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Khuyến mãi', style: context.textTheme.bodyLarge),
        CheckoutPromoCodeField(onApply: (code) async {}),
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(),
        //   ),
        //   child: Row(
        //     children: [
        //       const Expanded(
        //         child: TextField(
        //           decoration: InputDecoration(
        //             contentPadding: EdgeInsets.zero,
        //             border: OutlineInputBorder(
        //               borderSide: BorderSide.none,
        //             ),
        //             enabledBorder: OutlineInputBorder(
        //               borderSide: BorderSide.none,
        //             ),
        //             focusedBorder: OutlineInputBorder(
        //               borderSide: BorderSide.none,
        //             ),
        //           ),
        //         ),
        //       ),
        //       ClipRRect(
        //         borderRadius: BorderRadiusGeometry.circular(8),
        //         child: ElevatedButton(
        //           onPressed: () {},
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: context.colors.primaryContainer,
        //           ),
        //           child: Text(
        //             'Áp dụng',
        //             style: context.textTheme.bodyMedium!.copyWith(
        //               fontWeight: FontWeight.bold,
        //               color: context.colors.onPrimaryContainer,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
