part of 'scan_bloc.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

final class ScanInitial extends ScanState {}

final class Scanning extends ScanState {}

final class ScanSuccess extends ScanState {
  const ScanSuccess(this.shopId);

  final String shopId;

  @override
  List<Object> get props => [shopId];
}

final class ScanError extends ScanState {
  const ScanError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
