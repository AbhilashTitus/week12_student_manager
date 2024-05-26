import 'package:flutter/material.dart';
import 'student_list.dart';
import 'student_form.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';

class StudentView extends StatefulWidget {
  @override
  _StudentViewState createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  final StudentController _controller = StudentController();
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void fetchStudents() async {
    List<Student> fetchedStudents = await _controller.getStudents();
    setState(() {
      students = fetchedStudents;
    });
  }

  void refreshStudentList() {
    fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Management')),
      body: StudentList(students: students, onStudentUpdated: refreshStudentList),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          bool? shouldRefresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentForm(onStudentAdded: refreshStudentList),
            ),
          );

          if (shouldRefresh == true) {
            refreshStudentList();
          }
        },
      ),
    );
  }
}
