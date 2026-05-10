import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar.dart';
import '../../../data/mock/mock_feedback_reports.dart';

class AdminReportsAllScreen extends StatefulWidget {
  const AdminReportsAllScreen({super.key});

  @override
  State<AdminReportsAllScreen> createState() => _AdminReportsAllScreenState();
}

class _AdminReportsAllScreenState extends State<AdminReportsAllScreen> {
  static const Color kBg = Color(0xFFFEF9F2);
  static const Color kCard = Color(0xFFF8F3EC);
  static const Color kMuted = Color(0xFF404943);
  static const Color kGreen = Color(0xFF003925);

  final TextEditingController _search = TextEditingController();
  String _tab = 'All'; // All | Pending | Reviewed

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _showTopBanner(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearMaterialBanners();
    messenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: kGreen, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kGreen,
                ),
              ),
            ),
          ],
        ),
        actions: const [SizedBox.shrink()],
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) messenger.clearMaterialBanners();
    });
  }

  List<FeedbackReportMock> get _filtered {
    final q = _search.text.trim().toLowerCase();
    Iterable<FeedbackReportMock> items = kMockFeedbackReports;

    if (_tab == 'Pending') {
      items = items.where((e) => e.status == FeedbackReportStatus.pending);
    } else if (_tab == 'Reviewed') {
      items = items.where((e) => e.status == FeedbackReportStatus.reviewed);
    }

    if (q.isEmpty) return items.toList();

    return items
        .where(
          (e) =>
              e.reporterLabel.toLowerCase().contains(q) ||
              e.description.toLowerCase().contains(q) ||
              e.title.toLowerCase().contains(q) ||
              e.id.toLowerCase().contains(q),
        )
        .toList();
  }

  Future<void> _openDetails(FeedbackReportMock report) async {
    final result = await context.push<String>(
      '/admin/reports/${report.id}',
      extra: report,
    );

    if (!mounted || result == null) return;
    if (result == 'updated') _showTopBanner('Updated Successfully!');
    if (result == 'deleted') _showTopBanner('Deleted Successfully!');
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: kBg,
      appBar: const CustomAppBar(title: 'Reports'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: _SearchBar(
                controller: _search,
                onChanged: (_) => setState(() {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: _Tabs(
                value: _tab,
                onChanged: (v) => setState(() => _tab = v),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, i) {
                  final report = items[i];
                  return _ReportCard(
                    report: report,
                    cardColor: kCard,
                    muted: kMuted,
                    onPrimaryTap: () => _openDetails(report),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  static const Color kInputBg = Color(0xFFE6E2DB);

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: Color(0xFF77756F)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Search feedback...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  static const Color kGreen = Color(0xFF003925);
  static const Color kBg = Color(0xFFFEF9F2);
  static const Color kInputBg = Color(0xFFE6E2DB);

  final String value;
  final ValueChanged<String> onChanged;

  const _Tabs({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget chip(String label) {
      final selected = value == label;
      return GestureDetector(
        onTap: () => onChanged(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? kGreen : kBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: selected ? kGreen : kInputBg),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : const Color(0xFF404943),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        chip('All'),
        const SizedBox(width: 10),
        chip('Pending'),
        const SizedBox(width: 10),
        chip('Reviewed'),
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  static const Color kGreen = Color(0xFF003925);
  static const Color kImageBg = Color(0xFFE6E2DB);

  final FeedbackReportMock report;
  final Color cardColor;
  final Color muted;
  final VoidCallback onPrimaryTap;

  const _ReportCard({
    required this.report,
    required this.cardColor,
    required this.muted,
    required this.onPrimaryTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = report.status == FeedbackReportStatus.pending;
    final primaryLabel = isPending ? 'Review Feedback' : 'View Details';
    final primaryBg = isPending ? kGreen : const Color(0xFFE6E2DB);
    final primaryFg = isPending ? Colors.white : kGreen;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: kImageBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image_outlined,
                    size: 20, color: Color(0xFF77756F)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.reporterLabel,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D1C18),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      report.submittedLabel,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: report.status.chipBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  report.status.label,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: report.status.chipText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: 3,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFBA1A1A).withOpacity(0.20),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            report.description,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.45,
              color: Color(0xFF1D1C18),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPrimaryTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryBg,
                foregroundColor: primaryFg,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                primaryLabel,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

