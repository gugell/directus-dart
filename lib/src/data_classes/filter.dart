import 'package:meta/meta.dart';

/// Used for filtering data
///
/// It should be used inside a map as a value for comparisson
/// Example:
/// ```dart
/// final filter = {
///   'name': Filter.eq('John'),
///   'id': Filter.gte(5),
///   'amount': Filter.between(5, 10),
///   'or': Filter.or([
///     {'name': Filter.notEq('Evan')},
///     {'name': Filter.notEq('Mark')},
///   ])
/// };
/// ```
class Filter {
  /// Comparisson that will be done (equal, not equal, less then...).
  final String comparisson;

  /// Value to compare it to
  final dynamic value;

  /// Check if the values are equal
  Filter.custom(this.value, this.comparisson);

  /// Check if the values are equal
  Filter(this.value) : comparisson = 'eq';

  // Check if at least one filter is true.
  Filter.or(List<Map<String, Filter>> filters)
      : comparisson = 'or',
        value = filters;

  // Check if at least one filter is true.
  Filter.and(List<Map<String, Filter>> filters)
      : comparisson = 'and',
        value = filters;

  /// Check if the values are equal.
  Filter.eq(this.value) : comparisson = 'eq';

  /// Check if the values are not equal.
  Filter.notEq(this.value) : comparisson = 'neq';

  /// Check to see if field contains value.
  Filter.contains(this.value) : comparisson = 'contains';

  /// Check to see if field does not contain value.
  Filter.notContains(this.value) : comparisson = 'ncontains';

  /// Check to see if value in is provided list.
  Filter.isIn(List this.value) : comparisson = 'in';

  /// Check to see if field in not is provided list.
  Filter.notIn(List this.value) : comparisson = 'nin';

  /// Check to see if value is greater then.
  Filter.gt(this.value) : comparisson = 'gt';

  /// Check to see if value is greater then or equal.
  Filter.gte(this.value) : comparisson = 'gte';

  /// Check to see if value is less then.
  Filter.lt(this.value) : comparisson = 'lt';

  /// Check to see if value is less then or equal.
  Filter.lte(this.value) : comparisson = 'lte';

  /// Check to see if value is empty.
  Filter.empty()
      : comparisson = 'empty',
        value = true;

  /// Check to see if value is not empty.
  Filter.notEmpty()
      : comparisson = 'nempty',
        value = true;

  /// Check to see if value is null.
  Filter.isNull()
      : comparisson = 'null',
        value = true;

  /// Check to see if value is not null.
  Filter.notNull()
      : comparisson = 'nnull',
        value = true;

  /// Check to see if value is between.
  Filter.between(dynamic from, dynamic to)
      : comparisson = 'between',
        value = [from, to];

  /// Check to see if value is not between.
  Filter.notBetween(dynamic from, dynamic to)
      : comparisson = 'nbetween',
        value = [from, to];

  /// Convert [Filter][List] to [Map][List].
  ///
  /// This method is used for converting `and` and `or` filtering.
  @visibleForTesting
  List<Map<String, dynamic>> convertFilterList(List<Map<String, Filter>> filters) {
    // For every item in List convert value from Filter to Map.
    return filters
        .map(
          (filterMap) => filterMap.map((field, value) => value.toMapEntry(field)),
        )
        .toList();
  }

  /// Convert filter to [MapEntry], with provided [field] name.
  ///
  /// That way it can easily be converted to [Map] for passing to [Dio]
  MapEntry<String, dynamic> toMapEntry(String field) {
    // If value is a list of non filters
    if (comparisson == 'or' || comparisson == 'and') {
      return MapEntry(comparisson, convertFilterList(value));
    }
    return MapEntry(field, {comparisson: value});
  }
}

/// Needed because of Dart limitation.
mixin _Filter {}

/// Alias for [Filter].
class F = Filter with _Filter;
