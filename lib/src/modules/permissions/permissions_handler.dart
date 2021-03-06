// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';
import 'package:directus/src/modules/permissions/premission_converter.dart';

import 'directus_permission.dart';

class PermissionsHandler extends ItemsHandler<DirectusPermission> {
  PermissionsHandler({required Dio client})
      : super(
          'directus_permissions',
          client: client,
          converter: PermissionConverter(),
        );
}
