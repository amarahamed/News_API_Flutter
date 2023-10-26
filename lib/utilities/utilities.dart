import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

enum NewsType { headlines, headlinesCategorized, news }

String localTimeConvert(String utcTime) {
  DateTime utc = DateTime.parse(utcTime);

  return "${DateFormat('MMMM').format(utc)} ${utc.day} ${utc.year}  ${DateFormat('jm').format(utc)}";
}

Color colorWithOpacity = const Color(0xFF808080).withOpacity(0.4);

var textFieldDecoration = InputDecoration(
  hintText: "Search your interest",
  prefixIcon: const Icon(Icons.search),
  contentPadding: const EdgeInsets.all(5),
  filled: true,
  fillColor: colorWithOpacity,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(12),
  ),
);
