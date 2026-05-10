import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: const CustomAppBar(title: 'Command Center', back: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overseeing the framework of lost goods and the rhythm of recovery across NYT spaces.',
              style: TextStyle(
                color: AppTheme.descriptionText,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 14),
            _buildStatsPanel(),
            const SizedBox(height: 18),
            Text(
              'Management Modules',
              style: TextStyle(
                color: AppTheme.primaryGreen,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _ModuleCard(
              title: 'All Posted Items',
              subtitle: 'Organize, archive, and oversee posted findings.',
              chipLabel: 'Open Module',
              accentIcon: Icons.inventory_2_outlined,
              onTap: () => context.go('/admin/items'),
            ),
            const SizedBox(height: 12),
            _ModuleCard(
              title: 'All Claimed Items',
              subtitle: 'Inspect movement of claims and outcomes in real time.',
              chipLabel: 'Review Claims',
              accentIcon: Icons.fact_check_outlined,
              onTap: () => context.go('/admin/claims'),
            ),
            const SizedBox(height: 12),
            _ModuleCard(
              title: 'All Feedback',
              subtitle: 'Evaluate user sentiment and recurring concerns.',
              chipLabel: 'Open Reports',
              accentIcon: Icons.insights_outlined,
              onTap: () => context.go('/admin/reports'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsPanel() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.adminDashboardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _StatCard(
            label: 'TOTAL REPORTED ITEMS',
            value: '1,248',
            subtitle: '+17 this week',
            compact: false,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'PENDING CLAIMS',
                  value: '42',
                  subtitle: 'Needs Review',
                  compact: true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                  label: 'ACTIVE FEEDBACK',
                  value: '07',
                  subtitle: 'Requires Attention',
                  compact: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final bool compact;

  const _StatCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: compact ? 10 : 12,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.adminDashboardDeepGreen, AppTheme.primaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: compact ? 2 : 6),
          Text(
            value,
            style: TextStyle(
              fontSize: compact ? 24 : 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String chipLabel;
  final IconData accentIcon;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.chipLabel,
    required this.accentIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.grayBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                gradient: const LinearGradient(
                  colors: [Color(0xFFD5E0D9), Color(0xFFC7D4CC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(accentIcon, size: 46, color: AppTheme.primaryGreen),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.descriptionText,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.adminDashboardChip,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      chipLabel,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.adminDashboardChipText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
