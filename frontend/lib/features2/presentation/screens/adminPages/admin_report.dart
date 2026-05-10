import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/appbar.dart';
import '../../../data/mock/mock_feedback_reports.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F2),
      appBar: const CustomAppBar(title: 'Reports', back: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard Overview',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF003925),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.75,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'System health and recent activity.',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF404943),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
              const SizedBox(height: 32),

              // Stat Cards
              const _TotalReportsCard(),
              const SizedBox(height: 16),
              const _StatCard(
                label: 'Pending Reports',
                value: '84',
                subtitle: '14 require immediate review',
                subtitleColor: Color(0xFF404943),
                iconBgColor: Color(0xFFD2E8D9),
                icon: Icons.check_box_outlined,
                iconColor: Color(0xFF003925),
              ),
              const SizedBox(height: 16),
              const _StatCard(
                label: 'Active Reports',
                value: '23',
                subtitle: '5 flagged as urgent',
                subtitleColor: Color(0xFFBA1A1A),
                subtitleIcon: Icons.warning_amber_rounded,
                iconBgColor: Color(0xFFFFDAD6),
                icon: Icons.flag_outlined,
                iconColor: Color(0xFFBA1A1A),
              ),
              const SizedBox(height: 32),

              // Recent Feedback Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Feedback',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF003925),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/admin/reports/all'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF003925),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF003925).withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'View all reports',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              ...kMockFeedbackReports.take(2).map((r) {
                final isPending = r.status == FeedbackReportStatus.pending;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () => context.push('/admin/reports/${r.id}', extra: r),
                    child: _FeedbackCard(
                      name: r.reporterLabel,
                      time: r.submittedLabel,
                      status: r.status == FeedbackReportStatus.reviewed
                          ? 'REVIEWED'
                          : 'PENDING',
                      statusBgColor: r.status.chipBg,
                      statusTextColor: r.status.chipText,
                      feedback: r.description,
                      actionLabel: isPending ? 'Review' : 'Details',
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _TotalReportsCard extends StatelessWidget {
  const _TotalReportsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Gradient background
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.29, -0.29),
                    end: Alignment(0.71, 1.29),
                    colors: [Color(0xFF003925), Color(0xFF1D503A)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Reports',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF404943),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E2DB),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: const Icon(Icons.archive_outlined,
                        size: 16, color: Color(0xFF404943)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '1,248',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF003925),
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.11,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.trending_up,
                      size: 14, color: Color(0xFF003925)),
                  const SizedBox(width: 4),
                  Text(
                    '+12% this week',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF003925),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Generic Stat Card ────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color subtitleColor;
  final Color iconBgColor;
  final IconData icon;
  final Color iconColor;
  final IconData? subtitleIcon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.subtitleColor,
    required this.iconBgColor,
    required this.icon,
    required this.iconColor,
    this.subtitleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF404943),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.manrope(
              color: const Color(0xFF003925),
              fontSize: 36,
              fontWeight: FontWeight.w800,
              height: 1.11,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (subtitleIcon != null) ...[
                Icon(subtitleIcon, size: 14, color: subtitleColor),
                const SizedBox(width: 4),
              ],
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: subtitleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final String name;
  final String time;
  final String status;
  final Color statusBgColor;
  final Color statusTextColor;
  final String feedback;
  final String actionLabel;

  const _FeedbackCard({
    required this.name,
    required this.time,
    required this.status,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.feedback,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DB),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Icon(Icons.person_outline,
                    size: 16, color: Color(0xFF404943)),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: GoogleFonts.inter(
                  color: const Color(0xFF1D1C18),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• $time',
                style: GoogleFonts.inter(
                  color: const Color(0xFF404943),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    color: statusTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Feedback quote
          Text(
            feedback,
            style: GoogleFonts.manrope(
              color: const Color(0xFF1D1C18),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Action button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE6E2DB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              actionLabel,
              style: GoogleFonts.inter(
                color: const Color(0xFF003925),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}