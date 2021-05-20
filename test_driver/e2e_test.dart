// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter scanner Demo', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final homeScreen = find.byValueKey('homeScreen');
    final scanScreen = find.byValueKey('scanScreen');
    final reductionScreen = find.byValueKey('reductionScreen');
    final buttonScanner = find.byValueKey('scannButton');
    final navigationBar = find.byValueKey('NavigationBar');

    FlutterDriver driver;
    

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('Check button text', () async {
      expect(driver.getText(buttonScanner), "Scanner une promotion");
    });
  });
}
