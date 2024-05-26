class Student {
  String id;
  String name;
  int age;
  String batch;
  String email;
  String photoUrl;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.batch,
    required this.email,
    required this.photoUrl,
  });

  factory Student.fromMap(Map<String, dynamic> data, String documentId) {
    return Student(
      id: documentId,
      name: data['name'],
      age: data['age'],
      batch: data['batch'],
      email: data['email'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'batch': batch,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
