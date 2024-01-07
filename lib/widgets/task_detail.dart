import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; 
import '../models/task.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details', style: TextStyle(color: Colors.white)),
        centerTitle: true, 
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${task.name}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey)),
            SizedBox(height: 10),
            Text('Date: ${task.date}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 10),
            Text('Time: ${task.time}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 10),
            Text('Description: ${task.description}',
                style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 10),
            Text('Course: ${task.course}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 10),
            Text(
              task.dueDate,
              style: TextStyle(
                fontSize: 18.0,
                color: task
                    .getDueDateColor(), // Change the color based on whether the task is overdue
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Status: ${task.isDone ? "Completed" : "Not Completed"}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20), // Add some space before the animation
            Expanded(
              child: Lottie.asset(
                  'assets/animations/time.json'), // Display the Lottie animation
            ),
          ],
        ),
      ),
    );
  }
}
