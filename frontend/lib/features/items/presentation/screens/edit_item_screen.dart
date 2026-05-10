import 'package:flutter/material.dart';
import 'package:frontend/features/items/data/mock_data.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:go_router/go_router.dart';

class EditItemScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _verificationQuestionController;
  late TextEditingController _verificationAnswerController;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: (widget.item['title'] as String?) ?? '');
    _locationController = TextEditingController(text: (widget.item['location'] as String?) ?? '');
    _descriptionController = TextEditingController(
      text: (widget.item['description'] as String?) ?? '',
    );
    _verificationQuestionController = TextEditingController(
      text: (widget.item['verification_question'] as String?) ?? '',
    );
    _verificationAnswerController = TextEditingController(
      text: (widget.item['verification_answer'] as String?) ?? '',
    );
    _selectedCategory = (widget.item['category'] as String?) ?? 'Other';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _verificationQuestionController.dispose();
    _verificationAnswerController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final id = widget.item['id']?.toString();
    final title = _titleController.text.trim();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();
    final verificationQuestion = _verificationQuestionController.text.trim();
    final verificationAnswer = _verificationAnswerController.text.trim();

    if (id == null ||
        title.isEmpty ||
        location.isEmpty ||
        description.isEmpty ||
        verificationQuestion.isEmpty ||
        verificationAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    final updated = updateMockItem(
      id: id,
      title: title,
      location: location,
      description: description,
      category: _selectedCategory,
      verificationQuestion: verificationQuestion,
      verificationAnswer: verificationAnswer,
    );

    if (!updated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update item.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved successfully'),
        backgroundColor: Color(0xFF1B5E3E),
      ),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Item", back: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Edit Item Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                (widget.item['image_url'] as String?) ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => context.go('/post'),
                child: const Text(
                  'Change image from Post page',
                  style: TextStyle(color: Color(0xFF1B5E3E)),
                ),
              ),
            ),
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
            const SizedBox(height: 16),
            TextField(controller: _locationController, decoration: const InputDecoration(labelText: "Location")),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: const [
                DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                DropdownMenuItem(value: 'Accessories', child: Text('Accessories')),
                DropdownMenuItem(value: 'Documents', child: Text('Documents')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _selectedCategory = value);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _verificationQuestionController,
              decoration: const InputDecoration(
                labelText: "Verification key (Admin only)",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _verificationAnswerController,
              decoration: const InputDecoration(
                labelText: "Verification key possible answer",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E3E),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 46),
              ),
              child: const Text("Save Changes"),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Cancel edits",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}