import 'package:bot_toast/bot_toast.dart';
import 'package:what_2_eat/core/error/failures.dart';

void showFailureToast(Failure failure) {
  BotToast.showText(text: failure.message);
}

void showSuccessToast(String message) {
  BotToast.showText(text: message);
}
