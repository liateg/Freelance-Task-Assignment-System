import 'package:flutter/material.dart';

class AdminReportsDetailScreen extends StatefulWidget {
  const AdminReportsDetailScreen({super.key});

  @override
  State<AdminReportsDetailScreen> createState() =>
      _AdminReportsDetailScreenState();
}

class _AdminReportsDetailScreenState extends State<AdminReportsDetailScreen> {
  int _selectedNavIndex = 3; // REPORTS is active
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F2),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildFeedbackCard(),
                    const SizedBox(height: 24),
                    _buildModerationNotesCard(),
                    const SizedBox(height: 24),
                    _buildRelatedClaimCard(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xCCFEF9F2),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF003925),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Reports',
                style: TextStyle(
                  color: Color(0xFF003925),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
            ],
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
              color: Color(0xFF77756F),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FEEDBACK REPORT #FB-2023-892',
          style: TextStyle(
            color: Color(0xFF404943),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.80,
            height: 1.85,
          ),
        ),
        const Text(
          'Details',
          style: TextStyle(
            color: Color(0xFF003925),
            fontSize: 36,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
            letterSpacing: -1.40,
            height: 1.56,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF6C3838),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.hourglass_empty_rounded,
                  color: Color(0xFFFFDCDC), size: 16),
              SizedBox(width: 8),
              Text(
                'Pending Review',
                style: TextStyle(
                  color: Color(0xFFFFDCDC),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6E2DB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_outline,
                    color: Color(0xFF77756F), size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Alemayehu Eshete',
                    style: TextStyle(
                      color: Color(0xFF003925),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                  Text(
                    'alex.mercer@example.com •\nSubmitted Oct 24, 2023',
                    style: TextStyle(
                      color: Color(0xFF404943),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0x26C0C9C1), thickness: 1),
          ),
          // Written comment section
          const Text(
            'WRITTEN COMMENT',
            style: TextStyle(
              color: Color(0xFF404943),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.30,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '"The process of submitting a claim was fairly straightforward, but I was frustrated by the lack of updates over the first three days. I had to call twice to confirm my item was actually logged. Once I spoke to a representative, they were very helpful, but the initial silence was concerning."',
            style: TextStyle(
              color: Color(0xFF1D1C18),
              fontSize: 16,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              height: 1.63,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModerationNotesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x26C0C9C1)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.notes_rounded, color: Color(0xFF003925), size: 20),
              SizedBox(width: 8),
              Text(
                'Internal Moderation Notes',
                style: TextStyle(
                  color: Color(0xFF003925),
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 130),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0F1D1C18),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: TextField(
              controller: _notesController,
              maxLines: null,
              minLines: 5,
              style: const TextStyle(
                color: Color(0xFF1D1C18),
                fontSize: 16,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: 'Add confidential notes \nregarding this feedback...',
                hintStyle: TextStyle(
                  color: Color(0x7F404943),
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedClaimCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x26C0C9C1)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RELATED CLAIM',
            style: TextStyle(
              color: Color(0xFF404943),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.30,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 12),
          // Placeholder image box
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E2DB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.image_outlined,
                  color: Color(0xFF77756F), size: 48),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Black Leather Backpack',
            style: TextStyle(
              color: Color(0xFF003925),
              fontSize: 16,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
          const Text(
            'Claim ID: CLM-992-A',
            style: TextStyle(
              color: Color(0xFF404943),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Navigate to claim details
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Claim details coming soon')),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFECE7E1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'View Claim Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF003925),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.open_in_new_rounded,
                      color: Color(0xFF003925), size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E2DB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Mark as Reviewed
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked as reviewed!')),
                  );
                  // Navigate back after marking as reviewed
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.maybePop(context);
                  });
                },
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.white.withOpacity(0.1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Mark as Reviewed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Delete Feedback
          GestureDetector(
            onTap: () {
              _showDeleteDialog();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0x7FFFDAD6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x33BA1A1A)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.delete_outline_rounded,
                      color: Color(0xFFBA1A1A), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Delete Feedback',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFBA1A1A),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Feedback'),
        content: const Text(
            'Are you sure you want to delete this feedback? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback deleted!')),
              );
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.maybePop(context); // Go back after deletion
              });
            },
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFBA1A1A)),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.grid_view_rounded, 'label': 'DASHBOARD'},
      {'icon': Icons.inventory_2_outlined, 'label': 'ITEMS'},
      {'icon': Icons.assignment_outlined, 'label': 'CLAIMS'},
      {'icon': Icons.bar_chart_rounded, 'label': 'REPORTS'},
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: const Color(0xCCFEF9F2),
        border: Border(
          top: BorderSide(color: const Color(0x4CE6E2DB)),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (i) {
          final isActive = i == _selectedNavIndex;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedNavIndex = i);
              // Navigate to respective screens based on selection
              if (i == 0) {
                // Dashboard
                Navigator.pushNamed(context, '/admin-reports');
              } else if (i == 3) {
                // Already on reports
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${items[i]['label']} screen coming soon')),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                  horizontal: isActive ? 16 : 8, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF003925) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[i]['icon'] as IconData,
                    color: isActive
                        ? const Color(0xFFFEF9F2)
                        : const Color(0x7F1D1C18),
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items[i]['label'] as String,
                    style: TextStyle(
                      color: isActive
                          ? const Color(0xFFFEF9F2)
                          : const Color(0x7F1D1C18),
                      fontSize: 10,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}