import 'package:logger/logger.dart';

late Logger log;

class AuroraPrinter extends PrettyPrinter {
  AuroraPrinter()
      : super(
          methodCount: 0,
          errorMethodCount: 10,
          lineLength: 50,
          // colors: false,
          printEmojis: true,
        );
}
