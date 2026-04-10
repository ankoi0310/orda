import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';
import 'package:orda/features/shop/domain/usecases/load_shop_use_case.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({required LoadShopUseCase loadShop})
    : _loadShop = loadShop,
      super(ShopInitial()) {
    on<ShopEvent>((event, emit) => emit(ShopLoading()));
    on<LoadShop>(_onLoadShop);
  }

  final LoadShopUseCase _loadShop;

  Future<void> _onLoadShop(
    LoadShop event,
    Emitter<ShopState> emit,
  ) async {
    if (event.shopId == null) {
      emit(const ShopError('Mã cửa hàng không hợp lệ'));
      return;
    }

    final result = await _loadShop(event.shopId!);

    result.fold(
      (failure) => emit(ShopError(failure.message)),
      (shop) => emit(ShopLoaded(shop)),
    );
  }
}
