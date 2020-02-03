import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:news/core/networks/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call tp DataConnection.hasConnection', () async {
      // arrage
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection).thenAnswer((
          _) => tHasConnectionFuture);

      // act
      final res = networkInfoImpl.isConnected;

      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(res, tHasConnectionFuture);
    });
  });
}
