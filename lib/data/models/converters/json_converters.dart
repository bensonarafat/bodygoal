class TimestampConverter {
  static DateTime? timestampConvertFromJson(String? isoString) {
    return (isoString?.isNotEmpty ?? false)
        ? DateTime.parse(isoString!).toLocal()
        : null;
  }

  static String? timestampConverterToJson(DateTime? date) =>
      date?.toUtc().toIso8601String();
}

class NullToNumberConverter {
  static int intFromJson(int? value) {
    return value ?? 0;
  }
}
