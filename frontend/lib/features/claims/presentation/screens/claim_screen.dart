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
  String search = "";
  String statusType = "All";

  @override
  Widget build(BuildContext context) {
    if (mockClaims.isEmpty) {
      return const ClaimEmptyScreen();
    }

    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(
        title: 'My Claims',
        back: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.go('/admin/claims'),
                  icon: const Icon(Icons.admin_panel_settings, size: 16),
                  label: const Text(
                    'Admin',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Text(
              'Track the status of your lost and found claims here.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search claim...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField(
              value: statusType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: ["All", "Pending", "Approved", "Denied"].map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  statusType = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mockClaims.where((claim) {
                final titleMatch = claim.title
                    .toLowerCase()
                    .contains(search.toLowerCase());

                final claimStatus = claim.status
                    .toString()
                    .split('.')
                    .last
                    .toUpperCase();

                final statusMatch = statusType == "All" ||
                    claimStatus == statusType.toUpperCase();

                return titleMatch && statusMatch;
              }).length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final filteredClaims = mockClaims.where((claim) {
                  final titleMatch = claim.title
                      .toLowerCase()
                      .contains(search.toLowerCase());

                  final claimStatus = claim.status
                      .toString()
                      .split('.')
                      .last
                      .toUpperCase();

                  final statusMatch = statusType == "All" ||
                      claimStatus == statusType.toUpperCase();

                  return titleMatch && statusMatch;
                }).toList();

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