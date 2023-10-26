import 'package:intl/intl.dart';

enum NewsType { headlines, headlinesCategorized, news }

String localTimeConvert(String utcTime) {
  DateTime utc = DateTime.parse(utcTime);

  return "${DateFormat('MMMM').format(utc)} ${utc.day} ${utc.year}  ${DateFormat('jm').format(utc)}";
}
