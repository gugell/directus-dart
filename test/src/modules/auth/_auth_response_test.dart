// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/auth/_auth_response.dart';
import 'package:test/test.dart';

void main() {
  group('AuthResponse', () {
    late Map<String, Map<String, dynamic>> validResponse;

    setUp(
      () {
        validResponse = {
          'data': {'token': 'at'}
        };
      },
    );

    test('Constructor', () {
      final response =
          AuthResponse(accessToken: 'ac', accessTokenExpiresAt: DateTime.now());

      expect(response, isA<AuthResponse>());
    });

    test('fromRequest', () async {
      final request = Response(data: validResponse);
      final now = DateTime.now();
      final response = AuthResponse.fromResponse(request);

      expect(response.accessToken, 'at');
    });

    test('Throws if response data is null', () {
      expect(() => AuthResponse.fromResponse(Response()), throwsException);
    });

    test('Throws if access token does not exist', () {
      validResponse['data']?.remove('access_token');
      expect(() => AuthResponse.fromResponse(Response(data: validResponse)),
          throwsException);
    });

    test('Throws if expires does not exist', () {
      validResponse['data']?.remove('expires');
      expect(() => AuthResponse.fromResponse(Response(data: validResponse)),
          throwsException);
    });

    test('Throws if refresh token does not exist', () {
      validResponse['data']?.remove('refresh_token');
      expect(() => AuthResponse.fromResponse(Response(data: validResponse)),
          throwsException);
    });
  });
}
