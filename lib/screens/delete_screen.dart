import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final _idController = TextEditingController();
  final _firestoreService = FirestoreService();

  void _delete() async {
    if (_idController.text.isEmpty) return;
    
    await _firestoreService.deleteStudent(_idController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student deleted successfully')));
      _idController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Id',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _idController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _delete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Delete'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
