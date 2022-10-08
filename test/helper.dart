import 'package:flutter/material.dart';
import 'package:weather_widget_test_app/main.dart';

import 'mocks/app_http_client_mock.dart';
import 'mocks/location_mock_data_source.dart';

Widget launchMyApp() {
  return BlocsWidget(
    locationDataSource: LocationMockDataSource(),
    httpClient: MockAppHttpClient(),
    child: const MyApp(),
  );
}
