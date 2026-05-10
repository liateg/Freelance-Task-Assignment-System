import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import './claim_empty.dart';
import '../widgets/claim_card.dart';
import '../../data/mock/mock_claims.dart';
import 'claim_withdraw.dart';
import 'claim_delete.dart';

class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'ALL';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List get _filteredClaims {
    final query = _searchController.text.trim().toLowerCase();
    return mockClaims.where((claim) {
      final title = claim.title.toLowerCase();
      final description = claim.description.toLowerCase();
      final location = claim.location.toLowerCase();
      final matchesQuery = query.isEmpty ||
          title.contains(query) ||
          description.contains(query) ||
          location.contains(query);

      final status = claim.status.toString().split('.').last.toUpperCase();
      final matchesStatus = _selectedStatus == 'ALL' || status == _selectedStatus;

      return matchesQuery && matchesStatus;
    }).toList();
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppTheme.primaryGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedStatus = label);
        }
      },
      backgroundColor: Colors.transparent,
      selectedColor: AppTheme.primaryGreen,
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppTheme.primaryGreen : AppTheme.grayBorder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredClaims = _filteredClaims;

    if (mockClaims.isEmpty) {
      return const ClaimEmptyScreen();
    }

    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(title: 'My Claims', back: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Text(
              'Track the status of your lost and found claims here.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search claims...',
                hintStyle: const TextStyle(color: Colors.black38),
                prefixIcon: const Icon(Icons.search, color: Colors.black38),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.grayBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.grayBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF003925)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Filter Chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('ALL', _selectedStatus == 'ALL'),
                const SizedBox(width: 8),
                _buildFilterChip('PENDING', _selectedStatus == 'PENDING'),
                const SizedBox(width: 8),
                _buildFilterChip('APPROVED', _selectedStatus == 'APPROVED'),
                const SizedBox(width: 8),
                _buildFilterChip('REJECTED', _selectedStatus == 'REJECTED'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Claims List
          Expanded(
            child: filteredClaims.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.search_off, size: 60, color: Colors.grey),
                        const SizedBox(height: 12),
                        const Text(
                          'No claims found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _selectedStatus = 'ALL');
                          },
                          child: const Text('Reset filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredClaims.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final claimObj = filteredClaims[index];

                      final claimMap = {
                        'id': claimObj.id,
                        'title': claimObj.title,
                        'description': claimObj.description,
                        'date': claimObj.date.toString().split(' ')[0],
                        'status': claimObj.status
                            .toString()
                            .split('.')
                            .last
                            .toUpperCase(),
                        'imageUrl': claimObj.imageUrl ?? '',
                        'filedDate': claimObj.date.toString().split(' ')[0],
                      };
                      final status = claimMap['status'] ?? 'PENDING';
                      final isPending = status == 'PENDING';

                      return ClaimCard(
                        claim: claimMap,
                        onWithdraw: () async {

                          if (isPending) {
                            await showClaimWithdrawDialog(context);
                          } else {
                            await showClaimDeleteDialog(context);
                          }
                        },
                        onTap: () => context.go('/claims/${claimObj.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
