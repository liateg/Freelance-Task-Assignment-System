import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class ClaimItemDetailScreen extends StatefulWidget {
  final String itemId;

  const ClaimItemDetailScreen({super.key, required this.itemId});

  @override
  State<ClaimItemDetailScreen> createState() => _ClaimItemDetailScreenState();
}

class _ClaimItemDetailScreenState extends State<ClaimItemDetailScreen> {
  late TextEditingController itemNameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController uniqueMarksController;
  late TextEditingController contentsController;

  String? selectedDate;
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
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Claim Matching Item',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            size: 48,
                            color: AppTheme.grayText,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Tap to add image",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.grayText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "or upload from gallery",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.descriptionText,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(pickedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "ITEM DETAILS",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.grayText,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            _inputField(
              "Item Name",
              "e.g., Brown Leather Wallet",
              itemNameController,
            ),
            const SizedBox(height: 12),

            _inputField(
              "Description",
              "Describe distinguishing marks...",
              descriptionController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            const Text(
              "MATCHING EVIDENCE",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.grayText,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            _inputField(
              "Unique Marks or Scratches",
              "Any distinctive marks...",
              uniqueMarksController,
              maxLines: 2,
            ),
            const SizedBox(height: 12),

            _inputField(
              "Approximate Contents",
              "List items inside (ID card, keys...)",
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
                      "Cancel",
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
                      "Submit Claim",
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

  /// INPUT FIELD HELPER
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

  /// IMAGE PICKER
  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }
}
