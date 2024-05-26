import 'package:flutter/material.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';
import 'student_form.dart';

class StudentList extends StatefulWidget {
  final List<Student> students;
  final VoidCallback onStudentUpdated;

  StudentList({required this.students, required this.onStudentUpdated});

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final StudentController _controller = StudentController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students.length,
      itemBuilder: (context, index) {
        Student student = widget.students[index];
        return ListTile(
          leading: student.photoUrl.isNotEmpty ? Image.network(student.photoUrl) : null,
          title: Text(student.name),
          subtitle: Text(student.email),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  bool? shouldRefresh = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentForm(
                        student: student,
                        onStudentAdded: widget.onStudentUpdated,
                      ),
                    ),
                  );

                  if (shouldRefresh == true) {
                    widget.onStudentUpdated();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await _controller.deleteStudent(student.id);
                  widget.onStudentUpdated();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
