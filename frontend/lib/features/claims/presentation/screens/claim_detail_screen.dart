import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import '../../data/mock/mock_claims.dart';

class ClaimDetailScreen extends StatelessWidget {
  final String claimId;

  const ClaimDetailScreen({super.key, required this.claimId});

  @override
  Widget build(BuildContext context) {
    final claim = mockClaims.firstWhere(
      (c) => c.id == claimId,
      orElse: () => mockClaims.first,
    );

    final isApproved =
        claim.status.toString().split('.').last.toUpperCase() == 'APPROVED';

    final status = claim.status.toString().split('.').last.toUpperCase();

    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(
        title: 'Claim Details',
        back: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE HEADER
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: claim.imageUrl == null || claim.imageUrl!.isEmpty
                    ? Container(
                        color: AppTheme.grayBorder.withValues(alpha: 0.4),
                        child: const Icon(
                          Icons.image_outlined,
                          size: 60,
                          color: AppTheme.grayText,
                        ),
                      )
                    : Image.network(claim.imageUrl!, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 16),

            /// CONTENT CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE + STATUS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          claim.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isApproved
                              ? AppTheme.statusApprovedLight
                              : AppTheme.statusPendingLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isApproved
                                ? AppTheme.primaryGreen
                                : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// DESCRIPTION
                  Text(
                    claim.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppTheme.descriptionText,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// REPORT ID
                  const Text(
                    "REPORT ID",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.grayText,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "#RC-992-8810",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),

                  /// FOUNDER CONTACT (ONLY IF APPROVED)
                  if (isApproved) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "FOUNDER CONTACT INFO",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grayText,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.grayBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "elenaaati@gmail.com",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],

                  const SizedBox(height: 25),

                  /// FEEDBACK CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.feedbackCardBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 40,
                          color: AppTheme.primaryGreen,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "How was your experience?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Your feedback helps us improve the lost and found process for everyone on campus.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.feedbackText,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              "Leave a Feedback",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DEV BUTTON - TEST CLAIM ITEM DETAIL
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/claims/$claimId/item/item-123');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "[DEV] View Matching Item",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
