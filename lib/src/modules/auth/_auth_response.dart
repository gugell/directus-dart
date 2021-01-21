// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';

/// Response that is returned from login or refresh
class AuthResponse {
  /// Access token
  late String accessToken;

  /// [DateTime] when access token expires.
  ///
  /// It's using time of app time, not server time.
  late DateTime accessTokenExpiresAt;

  /// Constructor for manually creating object
  AuthResponse({required this.accessToken, required this.accessTokenExpiresAt});

  /// Create [AuthResponse] from [Dio] [Response] object.
  AuthResponse.fromResponse(Response response) {
    // Response is possible to be null in testing when we forget to return response.
    // ignore: unnecessary_null_comparison
    if (response == null || response.data == null) {
      throw DirectusError(
          message: 'Response and response data can\'t be null.');
    }

    final data = response.data?['data'];

    if (data == null) throw Exception('Login response is invalid.');

    final accessToken = data['token'];
    final accessTokenExpiresAt = DateTime.now().add(
      Duration(seconds: 3600),
    );

    if (accessToken == null) {
      throw DirectusError(message: 'Login response is invalid. => $data');
    }

    this.accessToken = accessToken;
    this.accessTokenExpiresAt = accessTokenExpiresAt;
  }
}
