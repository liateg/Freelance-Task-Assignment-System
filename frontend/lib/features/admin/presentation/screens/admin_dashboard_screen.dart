// lib/features/admin/presentation/screens/admin_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/router/app_router.dart';
import '../../../../utils/router/route_paths.dart';
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle
          Text(
            'Overseeing the framework of lost goods\nand their rightful owners with quiet precision.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Stats Row (3 cards)
          Row(
            children: [
              Expanded(child: _StatCard(
                title: 'TOTAL POSTED ITEMS',
                value: '1,248',
                subtext: '≈ 12% think it eek',
              )),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(
                title: 'PENDING CLAIMS',
                value: '42',
                action: 'Review Priority →',
                actionColor: const Color(0xFF1C3E1B),
              )),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(
                title: 'ACTIVE FEEDBACKS',
                value: '07',
                action: '⚠ Requires Attention',
                actionColor: Colors.orange,
              )),
            ],
          ),

          const SizedBox(height: 32),

          // Management Modules Title
          const Text(
            'Management Modules',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C3E1B),
            ),
          ),

          const SizedBox(height: 16),

          // Module 1: All Posted Items
          _ManagementCard(
            title: 'All Posted Items',
            description: 'Centralized database of all logged findings.',
            actionText: 'GLOBAL CATALOG',
            onTap: () {
              context.push(RoutePaths.adminItems);
            },
          ),

          const SizedBox(height: 12),

          // Module 2: All Claimed Items
          _ManagementCard(
            title: 'All Claimed Items',
            description: 'Historical record of successful reunions.',
            actionText: 'RESOLVED',
            onTap: () {
              context.push(RoutePaths.adminClaims);
            },
          ),

          const SizedBox(height: 12),

          // Module 3: All Feedbacks
          _ManagementCard(
            title: 'All Feedbacks',
            description: 'Disputes and user feedback requiring action.',
            actionText: 'ACTIVE QUEUE',
            onTap: () {
              context.push(RoutePaths.adminReports);
            },
          ),
        ],
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtext;
  final String? action;
  final Color? actionColor;

  const _StatCard({
    required this.title,
    required this.value,
    this.subtext,
    this.action,
    this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C3E1B),
            ),
          ),
          if (subtext != null) ...[
            const SizedBox(height: 4),
            Text(
              subtext!,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
              ),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 8),
            Text(
              action!,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: actionColor ?? Colors.grey.shade700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Management Card Widget
class _ManagementCard extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final VoidCallback onTap;

  const _ManagementCard({
    required this.title,
    required this.description,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C3E1B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1C3E1B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                actionText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C3E1B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}