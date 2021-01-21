import 'package:directus/src/modules/auth/_auth_response.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_directus_storage.dart';

void main() {
  group('AuthStorage', () {
    late MockDirectusStorage storage;
    late AuthStorage authStorage;

    setUp(() {
      storage = MockDirectusStorage();
      authStorage = AuthStorage(storage);
    });
    test('storeLoginData', () async {
      final now = DateTime.now();
      when(storage.setItem(any as dynamic, any))
          .thenAnswer((realInvocation) async {});
      await authStorage.storeLoginData(
        AuthResponse(
            accessToken: 'accessToken', accessTokenExpiresAt: DateTime.now()),
      );

      verify(storage.setItem(AuthFields.accessToken, 'accessToken')).called(1);
    });

    test('getLoginData', () async {
      when(storage.getItem(AuthFields.accessToken))
          .thenAnswer((realInvocation) async => 'at');
      final data = await authStorage.getLoginData();

      expect(data, isA<AuthResponse>());
      verify(storage.getItem(any as dynamic)).called(1);
    });
  });
}
