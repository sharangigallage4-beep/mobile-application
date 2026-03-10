import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/firestore_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _degreeController = TextEditingController();
  final _firestoreService = FirestoreService();

  void _submit() async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _degreeController.text.isEmpty) return;
    
    final student = Student(
      documentId: '',
      name: _nameController.text,
      studentId: _idController.text,
      degree: _degreeController.text,
    );
    
    await _firestoreService.addStudent(student);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student added successfully')));
      _nameController.clear();
      _idController.clear();
      _degreeController.clear();
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
      appBar: AppBar(title: const Text('Create')),
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
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Submit'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
