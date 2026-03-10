import 'package:flutter/material.dart';
import '../../utils/custom_snackbar.dart';
import '../models/student.dart';
import '../services/firestore_service.dart';
import 'update_screen.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Student Directory', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.teal.shade600,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade800, Colors.teal.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Student>>(
        stream: firestoreService.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.teal.shade600),
                  const SizedBox(height: 16),
                  Text('Loading records...', style: TextStyle(color: Colors.teal.shade600, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
          
          if (snapshot.hasError) {
             return Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.error_outline, size: 60, color: Colors.red.shade400),
                   const SizedBox(height: 16),
                   const Text('Something went wrong finding records.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                 ],
               ),
             );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text('No students found.', style: TextStyle(color: Colors.grey.shade600, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Add a new student to see them here.', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
                ],
              ),
            );
          }

          final students = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            itemCount: students.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final student = students[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Optional: Show student details
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  student.name.isNotEmpty ? student.name.substring(0, 1).toUpperCase() : '?',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal.shade700),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name, 
                                    style: const TextStyle(
                                      color: Colors.black87, 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                    )
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.badge_rounded, size: 14, color: Colors.teal.shade400),
                                      const SizedBox(width: 6),
                                      Text(
                                        student.studentId, 
                                        style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w500)
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.school, size: 14, color: Colors.orange.shade400),
                                      const SizedBox(width: 6),
                                      Flexible( // Wrap with Flexible to prevent overflow
                                        child: Text(
                                          student.degree, 
                                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit_rounded, color: Colors.orange.shade600),
                                tooltip: 'Edit Student',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UpdateScreen(student: student)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
