import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_picker/flutter_picker.dart';

const String buttonText = 'Show Dialog';

class TestPage extends StatelessWidget {
  const TestPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                Picker picker = new Picker(
                    adapter: PickerDataAdapter<String>(
                      pickerdata: <String>['0', '1', '2'],
                    ),
                    changeToFirst: true,
                    textAlign: TextAlign.left,
                    columnPadding: const EdgeInsets.all(8.0),
                    onConfirm: (Picker picker, List value) {});
                picker.showDialog(context);
              },
              child: const Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  group('Example Group', () {
    testGoldens(
      'Problem Example',
      (WidgetTester tester) async {
        final DeviceBuilder builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: <Device>[
            Device.phone,
            Device.iphone11,
            Device.tabletPortrait,
            Device.tabletLandscape,
          ])
          ..addScenario(
            widget: TestPage(),
            name: 'Example Scenario without the dialog',
          )
          ..addScenario(
            widget: TestPage(),
            name: 'Example Scenario with the dialog',
            onCreate: (Key scenarioWidgetKey) async {
              final Finder finder = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text(buttonText),
              );
              await tester.tap(finder);
            },
          );

        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(
          tester,
          'example_golden',
        );
      },
    );
  });
}
