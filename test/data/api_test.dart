import 'package:http/http.dart' as http;
import 'package:chicken/data/remote_test_api/remote_test_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('Get Test Api', () {
    late http.Client httpClient;
    late RemoteTestApi remoteTestApi;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      remoteTestApi = RemoteTestApi(httpClient: httpClient);
    });

    //   group('constructor', () {
    //     test('required an httpClient', () {
    //       expect(RemoteTestApi(), isNull);
    //     });
    // });
  });
}
