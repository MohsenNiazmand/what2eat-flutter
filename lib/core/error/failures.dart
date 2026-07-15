sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Session expired. Please login again',
  ]);
}

final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid input']);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

final class ConflictFailure extends Failure {
  const ConflictFailure([super.message = 'Resource already exists']);
}

final class AiProviderFailure extends Failure {
  const AiProviderFailure([
    super.message = 'AI service temporarily unavailable',
  ]);
}

/// Recipe moderation rejection from `POST /api/recipes/generate` (HTTP 422).
final class ModerationFailure extends Failure {
  const ModerationFailure({
    required String message,
    required this.code,
  }) : super(message);

  final String code;

  bool get isNonPersianText => code == 'NON_PERSIAN_TEXT';

  bool get isForbiddenIngredients => code == 'FORBIDDEN_INGREDIENTS';
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local storage error']);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred']);
}
