import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class CheckoutPromoCodeField extends StatefulWidget {
  const CheckoutPromoCodeField({required this.onApply, super.key});

  final Future<void> Function(String) onApply;

  @override
  State<CheckoutPromoCodeField> createState() =>
      _CheckoutPromoCodeFieldState();
}

class _CheckoutPromoCodeFieldState
    extends State<CheckoutPromoCodeField> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool _isApplying = false;

  Future<void> _applyCode() async {
    final code = _controller.text.trim();

    if (code.isEmpty) {
      setState(() => _errorText = 'Vui lòng nhập mã');
      return;
    }

    setState(() {
      _isApplying = true;
      _errorText = null;
    });

    try {
      await widget.onApply(code);
    } catch (e) {
      setState(() => _errorText = 'Mã không hợp lệ');
    } finally {
      setState(() => _isApplying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nhập mã khuyến mãi',
                    prefixIcon: const Icon(
                      Iconsax.ticket_discount_copy,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isApplying ? null : _applyCode,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: _isApplying
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Áp dụng'),
              ),
            ],
          ),
        ),
        if (_errorText != null)
          Text(
            _errorText!,
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.error,
            ),
          ),
      ],
    );
  }
}
