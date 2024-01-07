import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Task) onSubmit; // Callback for when a task is added

  AddTaskDialog({required this.onSubmit});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  // Controllers for the text fields
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final courseController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Function to select a date
  Future<void> _selectDate(BuildContext context) async {
    // Show date picker and update selectedDate
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // Set the firstDate to DateTime.now()
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Function to select a time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  void submitData() {
    // Check if all inputs are filled, create a new Task, and call onSubmit
    final enteredTitle = titleController.text;
    final enteredDescription = descriptionController.text;
    final enteredCourse = courseController.text;

    // Check if all the inputs are filled
    if (enteredTitle.isEmpty ||
        enteredDescription.isEmpty ||
        enteredCourse.isEmpty) {
      return;
    }

    // Create a new Task and call the onSubmit callback.
    widget.onSubmit(Task(
      name: enteredTitle,
      date:
          "${DateFormat('dd/MM/yyyy').format(selectedDate)}",
      time: "${selectedTime.format(context)}",
      description: enteredDescription,
      course: enteredCourse,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20), 
      ),
      elevation: 16,
      child: Container(
        padding:
            EdgeInsets.all(20), 
        child: ListView(
          shrinkWrap: true, // Makes the dialog just fit the content
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Task Name"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: "Description"),
            ),
            TextField(
              controller: courseController,
              decoration: InputDecoration(hintText: "Course"),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                  'Select date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}'), // Display the selected date in 'DD/MM/YYYY' format
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(
                  'Select time: ${selectedTime.format(context)}'), // Display the selected time
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: submitData,
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
