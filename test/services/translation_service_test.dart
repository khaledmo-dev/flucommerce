import 'package:flutter_test/flutter_test.dart';
import 'package:flucommerce/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TranslationServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
