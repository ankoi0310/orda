import 'package:orda/core/error/app_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthErrorMapper {
  static AppError map(Object error) {
    if (error is AuthApiException) {
      return _mapAuthApiError(error);
    }

    return const AppError(
      type: AppErrorType.unknown,
      message: 'Có lỗi xảy ra, vui lòng thử lại',
    );
  }

  static AppError _mapAuthApiError(AuthApiException error) {
    switch (error.code) {
      case 'invalid_credentials':
        return const AppError(
          type: AppErrorType.unauthorized,
          message: 'Email hoặc mật khẩu không đúng',
        );

      case 'email_not_confirmed':
        return const AppError(
          type: AppErrorType.validation,
          message: 'Email chưa được xác nhận',
        );

      case 'user_not_found':
        return const AppError(
          type: AppErrorType.unauthorized,
          message: 'Tài khoản không tồn tại',
        );

      case 'email_exists':
      case 'user_already_exists':
        return const AppError(
          type: AppErrorType.validation,
          message: 'Email đã được sử dụng',
        );

      case 'weak_password':
        return const AppError(
          type: AppErrorType.validation,
          message: 'Mật khẩu quá yếu',
        );

      case 'over_request_rate_limit':
        return const AppError(
          type: AppErrorType.rateLimit,
          message: 'Bạn thao tác quá nhanh, hãy thử lại sau',
        );

      case 'session_expired':
        return const AppError(
          type: AppErrorType.unauthorized,
          message: 'Phiên đăng nhập đã hết hạn',
        );

      default:
        return _mapByStatus(error);
    }
  }

  static AppError _mapByStatus(AuthApiException error) {
    switch (error.statusCode) {
      case '422':
        return const AppError(
          type: AppErrorType.validation,
          message: 'Dữ liệu không hợp lệ',
        );

      case '429':
        return const AppError(
          type: AppErrorType.rateLimit,
          message: 'Quá nhiều yêu cầu, thử lại sau',
        );

      case '500':
        return const AppError(
          type: AppErrorType.server,
          message: 'Lỗi hệ thống, thử lại sau',
        );

      default:
        return const AppError(
          type: AppErrorType.unknown,
          message: 'Có lỗi xảy ra',
        );
    }
  }
}
