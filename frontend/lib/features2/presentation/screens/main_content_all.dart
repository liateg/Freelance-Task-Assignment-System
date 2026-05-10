import 'package:flutter/material.dart';

class FeedbacksAllScreen extends StatelessWidget {
  const FeedbacksAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(context),
            _buildFilterTabs(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _buildPendingCard(
                    context,
                    studentId: 'Student #8821',
                    time: 'Today, 10:42 AM',
                    quote:
                        '"The process was okay, but finding my water bottle took a bit longer than expected at the desk."',
                  ),
                  const SizedBox(height: 16),
                  _buildReviewedCard(
                    context,
                    studentId: 'Student #4290',
                    time: 'Yesterday, 4:15 PM',
                    quote:
                        '"Incredibly fast and polite! Saved me so much stress before my midterm."',
                  ),
                  const SizedBox(height: 16),
                  _buildPendingCard(
                    context,
                    studentId: 'Student #9012',
                    time: 'Oct 24, 2:30 PM',
                    quote:
                        '"I was told my laptop was here but no one could find it when I arrived. Very frustrating."',
                    isNegative: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFFEF9F2),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F1D1C18),
            blurRadius: 32,
            offset: Offset(0, 12),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Color(0xFF003925), size: 22),
                SizedBox(width: 16),
                Text(
                  'Feedbacks',
                  style: TextStyle(
                    color: Color(0xFF003925),
                    fontSize: 20,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                    height: 1.40,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE6E2DB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFF003925),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          // Active tab - All
          GestureDetector(
            onTap: () {
              // Already on All screen, but you could add navigation logic here
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
              decoration: ShapeDecoration(
                color: const Color(0xFF003925),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x26003925),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: const Text(
                'All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Inactive tab - Pending
          GestureDetector(
            onTap: () {
              // Navigate to pending screen
              Navigator.pushNamed(context, '/feedbacks-pending');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
              decoration: ShapeDecoration(
                color: const Color(0xFFF8F3EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                  side: const BorderSide(color: Color(0x26C0C9C1), width: 1),
                ),
              ),
              child: const Text(
                'Pending',
                style: TextStyle(
                  color: Color(0xFF404943),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Inactive tab - Reviewed
          GestureDetector(
            onTap: () {
              // Navigate to reviewed screen
              Navigator.pushNamed(context, '/feedbacks-reviewed');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
              decoration: ShapeDecoration(
                color: const Color(0xFFF8F3EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                  side: const BorderSide(color: Color(0x26C0C9C1), width: 1),
                ),
              ),
              child: const Text(
                'Reviewed',
                style: TextStyle(
                  color: Color(0xFF404943),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingCard(
    BuildContext context, {
    required String studentId,
    required String time,
    required String quote,
    bool isNegative = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.desktop_windows_outlined,
                  color: Color(0xFF5C6B63),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentId,
                      style: const TextStyle(
                        color: Color(0xFF1D1C18),
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Color(0xFF404943),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DB),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0x26C0C9C1), width: 1),
                ),
                child: const Text(
                  'Pending',
                  style: TextStyle(
                    color: Color(0xFF404943),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: isNegative
                        ? const Color(0x7FBA1A1A)
                        : const Color(0xFFB9EFD0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    quote,
                    style: const TextStyle(
                      color: Color(0xFF1D1C18),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.63,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.47, 1.47),
                end: Alignment(0.53, -0.47),
                colors: [Color(0xFF003925), Color(0xFF1D503A)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate to update feedback screen
                  Navigator.pushNamed(context, '/submit-feedback');
                },
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.white.withOpacity(0.1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Update Feedback',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewedCard(
    BuildContext context, {
    required String studentId,
    required String time,
    required String quote,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF8F3EC), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x071D1C18),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.desktop_windows_outlined,
                  color: Color(0xFF5C6B63),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentId,
                      style: const TextStyle(
                        color: Color(0xFF1D1C18),
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Color(0xFF404943),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD2E8D9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Reviewed',
                  style: TextStyle(
                    color: Color(0xFF55695D),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC0C9C1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    quote,
                    style: const TextStyle(
                      color: Color(0xFF404943),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.63,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: const Color(0xFFECE7E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Handle delete action
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Feedback'),
                      content: const Text('Are you sure you want to delete this feedback?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform delete
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Feedback deleted')),
                            );
                          },
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Delete',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF003925),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}