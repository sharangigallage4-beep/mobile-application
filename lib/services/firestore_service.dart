import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionPath = 'students';

  Future<void> addStudent(Student student) async {
    await _db.collection(collectionPath).add(student.toMap());
  }

  Stream<List<Student>> getStudents() {
    return _db.collection(collectionPath).snapshots().map((snapshot) => 
        snapshot.docs.map((doc) => Student.fromMap(doc.id, doc.data())).toList());
  }

  Future<void> updateStudent(Student student) async {
    await _db.collection(collectionPath).doc(student.documentId).update(student.toMap());
  }

  Future<void> deleteStudent(String studentId) async {
    var snapshot = await _db.collection(collectionPath).where('studentId', isEqualTo: studentId).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
