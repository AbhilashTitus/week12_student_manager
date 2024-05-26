import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';
import 'dart:io';

class StudentForm extends StatefulWidget {
  final Student? student;

  StudentForm({this.student});

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _age;
  late String _batch;
  late String _email;
  File? _imageFile;

  final StudentController _controller = StudentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student == null ? 'Add Student' : 'Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.student?.name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: widget.student?.age.toString(),
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
                onSaved: (value) => _age = int.parse(value!),
              ),
              TextFormField(
                initialValue: widget.student?.batch,
                decoration: InputDecoration(labelText: 'Batch'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a batch';
                  }
                  return null;
                },
                onSaved: (value) => _batch = value!,
              ),
              TextFormField(
                initialValue: widget.student?.email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 20),
              _imageFile == null
                  ? (widget.student?.photoUrl.isNotEmpty ?? false
                      ? Image.network(widget.student!.photoUrl)
                      : Container())
                  : Image.file(_imageFile!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {
                        _imageFile = pickedFile != null ? File(pickedFile.path) : null;
                      });
                    },
                    child: Text('Pick from Gallery'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                      setState(() {
                        _imageFile = pickedFile != null ? File(pickedFile.path) : null;
                      });
                    },
                    child: Text('Take a Picture'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Student student = Student(
                      id: widget.student?.id ?? '',
                      name: _name,
                      age: _age,
                      batch: _batch,
                      email: _email,
                      photoUrl: '',
                    );

                    if (widget.student == null) {
                      await _controller.addStudent(student, _imageFile);
                    } else {
                      await _controller.updateStudent(student, _imageFile);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.student == null ? 'Add Student' : 'Update Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
