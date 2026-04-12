import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';
import 'package:orda/features/shop/domain/usecases/get_shop_use_case.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({required GetShopUseCase getShop})
    : _getShop = getShop,
      super(ShopInitial()) {
    on<ShopEvent>((event, emit) => emit(ShopLoading()));
    on<GetShop>(_onGetShop);
  }

  final GetShopUseCase _getShop;

  Future<void> _onGetShop(
    GetShop event,
    Emitter<ShopState> emit,
  ) async {
    final result = await _getShop(event.shopId);

    result.fold(
      (failure) => emit(ShopError(failure.message)),
      (shop) => emit(ShopLoaded(shop)),
    );
  }
}
