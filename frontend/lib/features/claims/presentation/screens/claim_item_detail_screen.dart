import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class ClaimItemDetailScreen extends StatefulWidget {
  final String itemId;

  const ClaimItemDetailScreen({super.key, required this.itemId});

  @override
  State<ClaimItemDetailScreen> createState() => _ClaimItemDetailScreenState();
}

class _ClaimItemDetailScreenState extends State<ClaimItemDetailScreen> {
  late final TextEditingController itemNameController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;
  late final TextEditingController uniqueMarksController;
  late final TextEditingController contentsController;

  File? pickedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    itemNameController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    uniqueMarksController = TextEditingController();
    contentsController = TextEditingController();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    uniqueMarksController.dispose();
    contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: const CustomAppBar(
        title: 'Claim Matching Item',
        back: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  border: Border.all(
                    color: pickedImage == null
                        ? AppTheme.grayBorder
                        : AppTheme.primaryGreen,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: pickedImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 48,
                            color: AppTheme.grayText,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tap to add image',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.grayText,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'or upload from gallery',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.descriptionText,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(
                          pickedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'ITEM DETAILS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.grayText,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            _inputField(
              'Item Name',
              'e.g., Brown Leather Wallet',
              itemNameController,
            ),
            const SizedBox(height: 12),
            _inputField(
              'Description',
              'Describe distinguishing marks...',
              descriptionController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'MATCHING EVIDENCE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.grayText,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            _inputField(
              'Unique Marks or Scratches',
              'Any distinctive marks...',
              uniqueMarksController,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            _inputField(
              'Approximate Contents',
              'List items inside (ID card, keys...)',
              contentsController,
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppTheme.grayBorder,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Claim submitted!')),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Submit Claim',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppTheme.white,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null && mounted) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }
}
