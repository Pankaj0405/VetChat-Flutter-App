class Country {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
          other is Country &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              code == other.code &&
              dialCode == other.dialCode &&
              flag == other.flag;

  @override
  int get hashCode =>
      name.hashCode ^ code.hashCode ^ dialCode.hashCode ^ flag.hashCode;

  @override
  String toString() {
    return 'Country{name: $name, code: $code, dialCode: $dialCode, flag: $flag}';
  }

  String toSearchString() {
    return '$name $code $dialCode $flag';
  }
}
