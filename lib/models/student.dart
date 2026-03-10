class Student {
  final String documentId;
  final String name;
  final String studentId;
  final String degree;

  Student({
    required this.documentId,
    required this.name,
    required this.studentId,
    required this.degree,
  });

  factory Student.fromMap(String docId, Map<String, dynamic> map) {
    return Student(
      documentId: docId,
      name: map['name'] ?? '',
      studentId: map['studentId'] ?? '',
      degree: map['degree'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'studentId': studentId,
      'degree': degree,
    };
  }
}
