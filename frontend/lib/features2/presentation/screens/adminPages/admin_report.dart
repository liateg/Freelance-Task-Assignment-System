import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F2),
      body: Stack(
        children: [
          // Scrollable body
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top AppBar space
                const SizedBox(height: 64),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 120,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
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
                              onTap: () {
                                // Navigate to all reports screen
                                Navigator.pushNamed(context, '/feedbacks-all');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF003925),
                                  borderRadius: BorderRadius.circular(9999),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF003925)
                                          .withOpacity(0.15),
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

                        GestureDetector(
                          onTap: () {
                            // Navigate to feedback details
                            _showFeedbackDetails(context, 'Alex Johnson');
                          },
                          child: const _FeedbackCard(
                            name: 'Alex Johnson',
                            time: '2h ago',
                            status: 'RESOLVED',
                            statusBgColor: Color(0xFFD2E8D9),
                            statusTextColor: Color(0xFF55695D),
                            feedback:
                                '"The return process was seamless. The staff at the library desk were very helpful in verifying my ID."',
                            actionLabel: 'Details',
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            // Navigate to feedback details
                            _showFeedbackDetails(context, 'Sarah Lee');
                          },
                          child: const _FeedbackCard(
                            name: 'Sarah Lee',
                            time: '5h ago',
                            status: 'ACTION NEEDED',
                            statusBgColor: Color(0xFFFFDAD6),
                            statusTextColor: Color(0xFF93000A),
                            feedback:
                                '"I couldn\'t find a way to update the description of my lost item after submitting the initial form."',
                            actionLabel: 'Review',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top App Bar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopAppBar(),
          ),

          // Bottom Nav Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomNavBar(),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDetails(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Feedback from $name'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This would show detailed feedback information.'),
            SizedBox(height: 8),
            Text('You can add reply, assign to team member, etc.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle action
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003925),
            ),
            child: const Text('Take Action'),
          ),
        ],
      ),
    );
  }
}

class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xCCFEF9F2),
      child: SafeArea(
        bottom: false,
        child: Container(
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
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back,
                        color: Color(0xFF003925), size: 20),
                    const SizedBox(width: 12),
                    Text(
                      'Reports',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF003925),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DB),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Icon(Icons.person_outline,
                    color: Color(0xFF404943), size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xCCFEF9F2),
        border: Border(
          top: BorderSide(color: const Color(0x4CE6E2DB), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F1D1C18),
            blurRadius: 32,
            offset: const Offset(0, -12),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.grid_view_rounded,
            label: 'DASHBOARD',
            active: true,
            onTap: () {
              // Already on dashboard
            },
          ),
          _NavItem(
            icon: Icons.inventory_2_outlined,
            label: 'ITEMS',
            active: false,
            onTap: () {
              // Navigate to items screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Items screen coming soon')),
              );
            },
          ),
          _NavItem(
            icon: Icons.assignment_outlined,
            label: 'CLAIMS',
            active: false,
            onTap: () {
              // Navigate to claims screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Claims screen coming soon')),
              );
            },
          ),
          _NavItem(
            icon: Icons.insert_drive_file_outlined,
            label: 'REPORTS',
            active: false,
            onTap: () {
              // Already on reports screen
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF003925) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: active ? Colors.white : const Color(0xFF77756F),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.manrope(
                color: active
                    ? const Color(0xFFFEF9F2)
                    : const Color(0xFF77756F),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                height: 1.5,
              ),
            ),
          ],
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