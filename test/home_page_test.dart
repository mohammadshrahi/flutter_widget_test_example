import 'package:flutter_test/flutter_test.dart';
import './helper.dart';
import 'mocks/app_http_client_mock.dart';

void main() {
  group('Home page', () {
    testWidgets(
        'Should show the weather data when its returned from datasource successfuly',
        (WidgetTester tester) async {
      await tester.pumpWidget(launchMyApp());
      await tester.pump();
      expect(find.text('Berlin'), findsOneWidget);
      expect(find.text('Humidity: 33'), findsOneWidget);

      expect(find.text('Temperature: 0'), findsOneWidget);
    });

    testWidgets('Should not shoing the weather data when the api call fail',
        (WidgetTester tester) async {
      MockAppHttpClient.setStatusCode(404);
      await tester.pumpWidget(launchMyApp());
      await tester.pump();
      expect(find.text('Berlin'), findsNothing);
      expect(find.text('Humidity: 33'), findsNothing);

      expect(find.text('Temperature: 0'), findsNothing);
    });
  });
}
