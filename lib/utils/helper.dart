import 'package:intl/intl.dart';


// Date formatter
// Example: Jan 01, 2025
String? dateFormatter({required String? dateTimeString}) {
    if (dateTimeString == null || dateTimeString.isEmpty) return null;
    try {
      DateTime date = DateTime.parse(dateTimeString);
      return DateFormat("MMM d, yyyy").format(date);
    } catch (e) {
      return null;
    }
  }