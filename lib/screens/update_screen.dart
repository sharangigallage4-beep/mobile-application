import 'package:flutter/material.dart';
import '../../utils/custom_snackbar.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _idController = TextEditingController(text: widget.student.studentId);
    _degreeController = TextEditingController(text: widget.student.degree);
  }

  void _update() async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _degreeController.text.isEmpty) {
      CustomSnackBar.showError(context, 'Please fill in all fields!');
      return;
    }
    
    setState(() => _isLoading = true);

    try {
      final updatedStudent = Student(
        documentId: widget.student.documentId,
        name: _nameController.text.trim(),
        studentId: _idController.text.trim(),
        degree: _degreeController.text.trim(),
      );
      
      await _firestoreService.updateStudent(updatedStudent);
      
      if (mounted) {
        CustomSnackBar.showSuccess(context, 'Student Record Updated! ✨');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Failed to update record: $e');
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
            prefixIcon: Icon(icon, color: Colors.orange.shade400),
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
        title: const Text('Edit Student', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.orange.shade500,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade700, Colors.orange.shade400],
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
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.manage_accounts_rounded, size: 80, color: Colors.orange.shade600),
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
                onPressed: _isLoading ? null : _update,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade500,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.orange.withOpacity(0.5),
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
                        'Confirm Update',
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
