import 'package:flutter/material.dart';
import '../../utils/custom_snackbar.dart';
import '../services/firestore_service.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final _idController = TextEditingController();
  final _firestoreService = FirestoreService();
  bool _isLoading = false;

  void _delete() async {
    if (_idController.text.isEmpty) {
      CustomSnackBar.showError(context, 'Please enter a Student ID!');
      return;
    }
    
    setState(() => _isLoading = true);

    try {
      await _firestoreService.deleteStudent(_idController.text.trim());
      
      if (mounted) {
        CustomSnackBar.showSuccess(context, 'Student Record Deleted Successfully 🗑️');
        _idController.clear();
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Failed to delete record: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Delete Student', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.red.shade600,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade800, Colors.red.shade500],
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
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_remove_rounded, size: 80, color: Colors.red.shade600),
            ),
            const SizedBox(height: 20),
            const Text(
              'Remove a record from the database',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.red.shade200, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _idController,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Enter Target Student ID',
                  labelStyle: TextStyle(color: Colors.red.shade400, fontWeight: FontWeight.normal),
                  prefixIcon: Icon(Icons.badge_outlined, color: Colors.red.shade400),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey.shade400),
                    onPressed: () => _idController.clear(),
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
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _delete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.red.withOpacity(0.5),
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
                        'PERMANENTLY DELETE',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
