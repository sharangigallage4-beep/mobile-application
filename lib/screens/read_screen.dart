import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/firestore_service.dart';
import 'update_screen.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Read')),
      body: StreamBuilder<List<Student>>(
        stream: firestoreService.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students found.'));
          }
          final students = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                color: Colors.blue[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                margin: const EdgeInsets.only(bottom: 12.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(student.studentId, style: const TextStyle(color: Colors.white, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(student.degree, style: const TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UpdateScreen(student: student)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
