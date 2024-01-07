import 'package:flutter/material.dart';
import '../models/task.dart'; 
import 'task_detail.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback delete;
  final VoidCallback toggleDone;

  TaskCard(
      {required this.task, required this.delete, required this.toggleDone});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: GestureDetector(
          onTap: toggleDone,
          child: Icon(Icons.task,
              color: task.isDone
                  ? Colors.green
                  : Colors.grey), // Check icon for completed tasks
        ),
        title: Text(
          task.name,
          style: TextStyle(fontSize: 18.0),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Course: ${task.course}'),
            Text(
              '${task.dueDate}',
              style: TextStyle(
                  color: task
                      .getDueDateColor()), // Change the color based on whether the task is overdue
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskDetailPage(task: task)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete,
                  color: Colors.red), // Delete icon for removing tasks
              onPressed: delete,
            ),
          ],
        ),
      ),
    );
  }
}
