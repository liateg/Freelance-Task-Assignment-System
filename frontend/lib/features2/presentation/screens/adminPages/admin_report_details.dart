import 'package:flutter/material.dart';

import '../../../../shared/widgets/appbar.dart';
import '../../../data/mock/mock_feedback_reports.dart';

class AdminReportsDetailScreen extends StatefulWidget {
  final FeedbackReportMock report;

  const AdminReportsDetailScreen({
    super.key,
    required this.report,
  });

  @override
  State<AdminReportsDetailScreen> createState() =>
      _AdminReportsDetailScreenState();
}

class _AdminReportsDetailScreenState extends State<AdminReportsDetailScreen> {
  late final TextEditingController _notesController = TextEditingController(
    text: widget.report.moderationNote ?? '',
  );

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F2),
      appBar: const CustomAppBar(title: 'Reports'),
      body: SafeArea(
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
              _buildActionButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final status = widget.report.status;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FEEDBACK REPORT #${widget.report.id}',
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
            color: status == FeedbackReportStatus.pending
                ? const Color(0xFF6C3838)
                : const Color(0xFF55695D),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                status == FeedbackReportStatus.pending
                    ? Icons.hourglass_empty_rounded
                    : Icons.check_circle_outline_rounded,
                color: status == FeedbackReportStatus.pending
                    ? const Color(0xFFFFDCDC)
                    : const Color(0xFFD2E8D9),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                status == FeedbackReportStatus.pending
                    ? 'Pending Review'
                    : 'Reviewed',
                style: TextStyle(
                  color: status == FeedbackReportStatus.pending
                      ? const Color(0xFFFFDCDC)
                      : const Color(0xFFD2E8D9),
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
                children: [
                  Text(
                    widget.report.reporterLabel,
                    style: const TextStyle(
                      color: Color(0xFF003925),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                  Text(
                    widget.report.submittedLabel,
                    style: const TextStyle(
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
          Text(
            widget.report.description,
            style: const TextStyle(
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
          if (widget.report.tags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.report.tags
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF9F2),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: const Color(0x26C0C9C1)),
                      ),
                      child: Text(
                        t,
                        style: const TextStyle(
                          color: Color(0xFF003925),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
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
                  if (widget.report.status == FeedbackReportStatus.reviewed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This feedback is already reviewed.'),
                      ),
                    );
                    return;
                  }
                  _showMarkReviewedDialog();
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

  void _showMarkReviewedDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: const Text('Mark Feedback as Reviewed'),
        content: const Text(
          'Are you sure you want to mark this feedback as reviewed? This will update the community ratings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.maybePop(context, 'updated');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003925),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
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
              Navigator.pop(context);
              Navigator.maybePop(context, 'deleted');
            },
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFBA1A1A)),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}