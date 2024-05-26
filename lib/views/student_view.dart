import 'package:flutter/material.dart';
import 'student_list.dart';
import 'student_form.dart';

class StudentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Management')),
      body: StudentList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentForm()),
          );
        },
      ),
    );
  }
}
