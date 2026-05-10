import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

/// Shows a modal dialog used by admins after a claim is approved.
Future<void> showAdminClaimConfirmedDialog(BuildContext context,
    {VoidCallback? onContinue}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: AdminClaimConfirmedDialog(onContinue: onContinue),
    ),
  );
}

class AdminClaimConfirmedDialog extends StatelessWidget {
  final VoidCallback? onContinue;

  const AdminClaimConfirmedDialog({super.key, this.onContinue});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.check_circle,
                  size: 44,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              'Claim Confirmed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryGreen,
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            Text(
              'The ownership has been verified successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.grayText,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 18),

            // Dispatch card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.grayBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.statusApprovedLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.local_shipping_outlined,
                        size: 22,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Processing Dispatch',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'The delivery location and next steps will be shared with the claimant shortly.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.grayText,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onContinue != null) onContinue!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white, // 👈 fixes text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // extra safety
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}