import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/student_model.dart';
import 'dart:io';

class StudentController {
  final CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(Student student, File? imageFile) async {
    if (imageFile != null) {
      String imageUrl = await uploadImage(imageFile);
      student.photoUrl = imageUrl;
    }
    await studentsCollection.add(student.toMap());
  }

  Future<void> updateStudent(Student student, File? imageFile) async {
    if (imageFile != null) {
      String imageUrl = await uploadImage(imageFile);
      student.photoUrl = imageUrl;
    }
    await studentsCollection.doc(student.id).update(student.toMap());
  }

  Future<void> deleteStudent(String id) async {
    await studentsCollection.doc(id).delete();
  }

  Future<List<Student>> getStudents() async {
    QuerySnapshot querySnapshot = await studentsCollection.get();
    return querySnapshot.docs
        .map((doc) => Student.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    Reference storageRef = FirebaseStorage.instance.ref().child('student_photos/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
