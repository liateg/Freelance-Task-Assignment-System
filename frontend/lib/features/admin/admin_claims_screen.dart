import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../claims/data/mock/mock_claims.dart';
import '../claims/data/model/claim_model.dart';
import '../claims/enum/claim_status.dart';
import '../claims/presentation/widgets/admin.claim_card.dart';
import '../../shared/widgets/appbar.dart';
import '../../utils/theme/app_theme.dart';

/// Admin "Claimed Inventory" — matches design: search, ALL / PENDING filters, cards.
class AdminClaimsScreen extends StatefulWidget {
  const AdminClaimsScreen({super.key});

  @override
  State<AdminClaimsScreen> createState() => _AdminClaimsScreenState();
}

class _AdminClaimsScreenState extends State<AdminClaimsScreen> {
  static const Color _bg = Color(0xFFFEF9F2);
  static const Color _green = Color(0xFF003925);
  static const Color _muted = Color(0xFF404943);

  final TextEditingController _search = TextEditingController();
  bool _pendingOnly = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Claim> get _filtered {
    final q = _search.text.trim().toLowerCase();
    return mockClaims.where((c) {
      if (_pendingOnly && c.status != ClaimStatus.pending) return false;
      if (q.isEmpty) return true;
      return c.title.toLowerCase().contains(q) ||
          c.location.toLowerCase().contains(q) ||
          c.category.toLowerCase().contains(q);
    }).toList();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final claimDay = DateTime(date.year, date.month, date.day);

    if (claimDay == today) {
      return 'TODAY';
    } else if (claimDay == yesterday) {
      return 'YESTERDAY';
    }
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: _bg,
      appBar: const CustomAppBar(title: 'Claimed Items', back: false),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Claimed Inventory',
                    style: TextStyle(
                      fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                      color: AppTheme.primaryGreen,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Review and manage possession ownership claims submitted by students and staff.',
                    style: TextStyle(
                      color: _muted,
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E2DB),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: TextField(
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: 'Search by items',
                        hintStyle: TextStyle(
                          color: Color(0x99404943),
                          fontSize: 15,
                        ),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF77756F)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _filterChip(
                        label: 'ALL',
                        selected: !_pendingOnly,
                        onTap: () => setState(() => _pendingOnly = false),
                      ),
                      const SizedBox(width: 10),
                      _filterChip(
                        label: 'PENDING',
                        selected: _pendingOnly,
                        showFilterIcon: true,
                        onTap: () => setState(() => _pendingOnly = true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (list.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_2_outlined,
                        size: 56, color: AppTheme.grayText),
                    const SizedBox(height: 12),
                    Text(
                      _pendingOnly
                          ? 'No pending claims match your filters.'
                          : 'No claims match your search.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.grayText, fontSize: 15),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
              sliver: SliverList.separated(
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final claim = list[index];
                  return AdminClaimCard(
                    title: claim.title,
                    location: claim.location,
                    imageUrl: claim.imageUrl ?? '',
                    date: _formatDate(claim.date),
                    onPressed: () => context.go('/admin/claims/${claim.id}'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _filterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    bool showFilterIcon = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? _green : const Color(0xFFE6E2DB),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? _green : const Color(0x26C0C9C1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showFilterIcon) ...[
                Icon(
                  Icons.tune_rounded,
                  size: 16,
                  color: selected ? Colors.white : _muted,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: selected ? Colors.white : _muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
