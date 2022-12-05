import 'package:flutter/material.dart';
// Datepicker with Timepicker
Future<DateTime?> myDateTimePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day);

  if (picked != null) {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      DateTime dateTime = DateTime(
          picked.year, picked.month, picked.day, time.hour, time.minute);
      return dateTime;
    }
  }
}
