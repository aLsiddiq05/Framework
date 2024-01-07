import 'package:flutter/material.dart';
import 'models/task.dart'; 
import 'widgets/add_task.dart'; 
import 'widgets/task_card.dart'; 
import 'widgets/search.dart';

void main() => runApp(MaterialApp(home: MyMainPage()));

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  List<Task> _todoRecords = [
    Task(
        name: 'Task 1',
        date: '09/12/2023',
        time: '10:00 AM',
        description: 'This is a description of Task 1.',
        course: 'Course 1'),
    Task(
        name: 'Task 2',
        date: '08/12/2023',
        time: '6:00 AM',
        description: 'This is a description of Task 1.',
        course: 'Course 2'),
    Task(
        name: 'Task 3',
        date: '09/12/2023',
        time: '10:00 AM',
        description: 'This is a description of Task 1.',
        course: 'course 1'),
  ];

  String? selectedCourse;

  void toggleDone(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void deleteTask(Task task) {
    setState(() {
      _todoRecords.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    //filter task in a lowercase
    var filteredTasks = _todoRecords
        .where((task) =>
            task.course.toLowerCase() == selectedCourse?.toLowerCase() ||
            selectedCourse == null)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tasks List'),
            CourseSearchBar(
              tasks: _todoRecords,
              onCourseSelected: (course) {
                setState(() {
                  selectedCourse = course;
                });
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                selectedCourse = null;
              });
            },
          ),
        ],
      ),
      body: _todoRecords.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_task.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'There is no task right now',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final toDo = filteredTasks[index];
                return TaskCard(
                  task: toDo,
                  delete: () => deleteTask(toDo),
                  toggleDone: () => toggleDone(toDo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_task),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AddTaskDialog(onSubmit: (task) {
            setState(() {
              _todoRecords.add(task);
            });
          }),
        ),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
