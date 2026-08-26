import 'package:intl/intl.dart';

class HarvestFormatters {
  /// Always enforce Western digits and Indian grouping (lakh/crore).
  static String formatNumber(num value) {
    // en_IN ensures Indian grouping (e.g. 1,00,000)
    // We do not pass locale from the app here to avoid falling back to
    // native numeral glyphs (like Devanagari numerals) per Phase 2 requirements.
    final formatter = NumberFormat.decimalPattern('en_IN');
    return formatter.format(value);
  }

  /// Formats currency with ₹ directly prepended (no space).
  static String formatCurrency(num value) {
    final formattedNumber = formatNumber(value);
    return '₹$formattedNumber';
  }

  /// Formats percentage directly appended (no space).
  static String formatPercentage(num value) {
    final formattedNumber = formatNumber(value);
    return '$formattedNumber%';
  }

  /// Short date format: 'd MMM' (e.g., '14 Jun').
  static String formatDateShort(DateTime date, String localeCode) {
    // Uses the actual locale so the month name is translated, but the format is fixed.
    final formatter = DateFormat('d MMM', localeCode);
    return formatter.format(date);
  }
}
