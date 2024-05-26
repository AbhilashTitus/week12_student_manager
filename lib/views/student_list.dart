import 'package:flutter/material.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';
import 'student_form.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final StudentController _controller = StudentController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: _controller.getStudents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<Student> students = snapshot.data!;

        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            Student student = students[index];
            return ListTile(
              leading: student.photoUrl.isNotEmpty ? Image.network(student.photoUrl) : null,
              title: Text(student.name),
              subtitle: Text(student.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentForm(student: student),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _controller.deleteStudent(student.id);
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
