import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/firestore_service.dart';

class UpdateScreen extends StatefulWidget {
  final Student student;

  const UpdateScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _nameController;
  late TextEditingController _idController;
  late TextEditingController _degreeController;
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _idController = TextEditingController(text: widget.student.studentId);
    _degreeController = TextEditingController(text: widget.student.degree);
  }

  void _update() async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _degreeController.text.isEmpty) return;
    
    final updatedStudent = Student(
      documentId: widget.student.documentId,
      name: _nameController.text,
      studentId: _idController.text,
      degree: _degreeController.text,
    );
    
    await _firestoreService.updateStudent(updatedStudent);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student updated successfully')));
      Navigator.pop(context);
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => controller.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            _buildTextField('Name', _nameController),
            _buildTextField('Id', _idController),
            _buildTextField('Degree', _degreeController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _update,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Update'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
