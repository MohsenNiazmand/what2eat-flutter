import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerLazySingleton<Logger>(
    () => Logger(
      printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
    ),
  );
}
