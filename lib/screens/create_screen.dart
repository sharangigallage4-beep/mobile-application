import 'package:flutter/material.dart';
import '../../utils/custom_snackbar.dart';
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
  bool _isLoading = false;

  void _submit() async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _degreeController.text.isEmpty) {
      CustomSnackBar.showError(context, 'Please fill in all fields!');
      return;
    }
    
    setState(() => _isLoading = true);

    try {
      final student = Student(
        documentId: '',
        name: _nameController.text.trim(),
        studentId: _idController.text.trim(),
        degree: _degreeController.text.trim(),
      );
      
      await _firestoreService.addStudent(student);
      
      if (mounted) {
        CustomSnackBar.showSuccess(context, 'Student Record Created Successfully! 🎉');
        _nameController.clear();
        _idController.clear();
        _degreeController.clear();
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Failed to create record: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.blueGrey.shade400),
            prefixIcon: Icon(icon, color: Colors.blue.shade400),
            suffixIcon: IconButton(
              icon: Icon(Icons.close, color: Colors.grey.shade400),
              onPressed: () => controller.clear(),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Add New Student', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.blue.shade600,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_add_rounded, size: 80, color: Colors.blue.shade600),
            ),
            const SizedBox(height: 30),
            _buildTextField('Full Name', _nameController, Icons.person_outline),
            _buildTextField('Student ID', _idController, Icons.badge_outlined),
            _buildTextField('Degree Program', _degreeController, Icons.school_outlined),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.blue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading 
                    ? const SizedBox(
                        height: 25, 
                        width: 25, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
                      )
                    : const Text(
                        'Submit Record',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
