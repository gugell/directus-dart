import 'package:directus/src/modules/files/directus_file.dart';
import 'package:directus/src/modules/files/file_converter.dart';
import 'package:test/test.dart';

void main() {
  test('FileConverter', () {
    final converter = FileConverter();
    final fileMap = converter
        .toJson(DirectusFile(id: 1, description: 'Desc', uploadedBy: 5));
    expect(fileMap, isMap);
    final file = converter.fromJson(fileMap);
    expect(file, isA<DirectusFile>());
  });
}
