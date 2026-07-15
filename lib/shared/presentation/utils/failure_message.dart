import 'package:flutter/material.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';

String failureMessage(BuildContext context, Failure failure) {
  return switch (failure) {
    NetworkFailure() => context.tr.networkError,
    UnauthorizedFailure() => context.tr.sessionExpired,
    AiProviderFailure() => context.tr.aiProviderFailure,
    ModerationFailure() => failure.message,
    ValidationFailure() => failure.message,
    ConflictFailure() => failure.message,
    NotFoundFailure() => failure.message,
    ServerFailure() => failure.message.isNotEmpty
        ? failure.message
        : context.tr.genericError,
    CacheFailure() => context.tr.genericError,
    UnknownFailure() => context.tr.genericError,
  };
}
