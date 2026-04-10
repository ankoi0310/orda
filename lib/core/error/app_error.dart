enum AppErrorType {
  network,
  unauthorized,
  validation,
  rateLimit,
  server,
  unknown,
}

class AppError {
  const AppError({
    required this.type,
    required this.message,
    this.code,
  });

  final AppErrorType type;
  final String message;
  final String? code;
}
