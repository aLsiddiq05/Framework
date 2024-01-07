import 'package:flutter/material.dart';
import '../models/task.dart';

class CourseSearchBar extends StatefulWidget {
  // The list of tasks to display in the dropdown.
  final List<Task> tasks;
  // A callback that is called when a course is selected.
  final ValueChanged<String?> onCourseSelected;

  CourseSearchBar({required this.tasks, required this.onCourseSelected});

  @override
  _CourseSearchBarState createState() => _CourseSearchBarState();
}

class _CourseSearchBarState extends State<CourseSearchBar> {
  @override
  Widget build(BuildContext context) {
    // Get a list of unique courses, ignoring case
    var uniqueCourses =
        widget.tasks.map((task) => task.course.toLowerCase()).toSet().toList();

    // Convert the list back to the original case
    uniqueCourses = uniqueCourses
        .map((course) => widget.tasks
            .firstWhere((task) => task.course.toLowerCase() == course)
            .course)
        .toList();

    // Return a dropdown button with the list of unique courses.
    // When a course is selected, the onCourseSelected callback is called with the selected course.
    return DropdownButton<String>(
      hint: Text('Select a course'),
      onChanged: (String? newValue) {
        widget.onCourseSelected(newValue);
      },
      items: uniqueCourses.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
