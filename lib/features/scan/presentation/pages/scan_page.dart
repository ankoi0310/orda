import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/presentation/widgets/loading_widget.dart';
import 'package:orda/core/utils/app_util.dart';
import 'package:orda/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:orda/features/scan/presentation/widgets/dark_overlay.dart';
import 'package:orda/features/scan/presentation/widgets/qr_scan_overlay.dart';
import 'package:orda/features/shop/presentation/bloc/shop_bloc.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
  );

  StreamSubscription<Object?>? _subscription;
  Barcode? _barcode;

  bool isProcessing = false;

  void _handleBarcode(BarcodeCapture capture) {
    if (mounted) {
      setState(() {
        _barcode = capture.barcodes.firstOrNull;
      });

      if (_barcode != null) {
        context.read<ShopBloc>().add(
          LoadShop(shopId: _barcode?.displayValue),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(controller.start());
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose of the controller.
    await controller.dispose();
    // Dispose the widget itself.
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      listener: (context, state) async {
        if (state is ShopError) {
          setState(() {
            isProcessing = false;
          });
          await controller.start();

          if (!mounted) return;

          showSnackBar(context, content: state.message);
        }

        if (state is ShopLoaded) {
          await controller.stop();
          context.read<CartBloc>().add(
            SetShop(shopId: state.shop.id),
          );
          context.pushReplacement(AppRouter.shopDetail);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: context.colors.surfaceBright,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            alignment: Alignment.center,
            children: [
              MobileScanner(
                controller: controller,
                onDetect: (capture) async {
                  if (isProcessing) return;

                  setState(() {
                    isProcessing = true;
                  });
                  await controller.stop();

                  _handleBarcode(capture);
                },
              ),
              const DarkOverlay(),
              const QrScannerOverlay(),
              // const ScanLine(),
              if (state is ShopLoading)
                const LoadingWidget(text: 'Đang quét...'),
            ],
          ),
        );
      },
    );
  }
}
