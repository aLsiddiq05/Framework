import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Task {
  String name;
  String date;
  String time;
  String description;
  String course;
  bool isDone;
  String dueDate;

  Task({
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    required this.course,
    this.isDone = false,
  }) : dueDate = _calculateDueDate(date, time);

  static String _calculateDueDate(String date, String time) {
    // Convert the task's time string into a TimeOfDay object
    final split = time.split(' ');
    final timeSplit = split[0].split(':');
    int hour = int.parse(timeSplit[0]);
    final minute = int.parse(timeSplit[1]);
    if (split[1] == 'PM') hour += 12;

    // Parse the task's date into a DateTime object and add the task's time
    DateTime taskDateTime = DateFormat('dd/MM/yyyy')
        .parse(date)
        .add(Duration(hours: hour, minutes: minute));

    // Calculate the difference between the current date and time and the task's date and time
    Duration difference = taskDateTime.difference(DateTime.now());

    // Prepare the due string
    String dueString;
    if (difference.isNegative) {
      dueString = 'Overdue by:';
      difference =
          difference.abs(); //difference is made positive using difference.abs()
    } else {
      dueString = 'Due in:';
    }

/*difference.inDays > 0: This checks if the difference in days between the two DateTime objects is greater than 0. If it is, it adds the number of days to dueString.
difference.inHours % 24 > 0: This checks if the difference in hours (excluding whole days) between the two DateTime objects is greater than 0. If it is, it adds the number of hours to dueString.
difference.inMinutes % 60 > 0: This checks if the difference in minutes (excluding whole hours) between the two DateTime objects is greater than 0. If it is, it adds the number of minutes to dueString.
return dueString;: This returns the formatted string.*/
    if (difference.inDays > 0) {
      dueString += ' ${difference.inDays} days,';
    }
    if (difference.inHours % 24 > 0) {
      dueString += ' ${difference.inHours % 24} hours,';
    }
    if (difference.inMinutes % 60 > 0) {
      dueString += ' ${difference.inMinutes % 60} minutes';
    }

    return dueString;
  }

  Color getDueDateColor() {
    return dueDate.startsWith('Overdue') ? Colors.red : Colors.black;
  }
}
