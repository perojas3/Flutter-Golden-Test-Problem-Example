import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

// based in the instructions of this library: https://pub.dev/packages/golden_toolkit
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  return testMain();
}
