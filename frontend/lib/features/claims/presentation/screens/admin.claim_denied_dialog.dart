import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

/// Shows a modal dialog used by admins after a claim is rejected.
Future<void> showAdminClaimDeniedDialog(BuildContext context,
    {VoidCallback? onBack}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: AdminClaimDeniedDialog(onBack: onBack),
    ),
  );
}

class AdminClaimDeniedDialog extends StatelessWidget {
  final VoidCallback? onBack;

  const AdminClaimDeniedDialog({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small status pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.adminCardBackground,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'FINAL STATUS UPDATE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.grayText,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Title row with icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 36,
                      color: AppTheme.accentRed,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Claim Denied',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'The claim has been rejected and the user has been notified. This action is now permanent in the concierge archives.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.descriptionText,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            // Back button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onBack != null) onBack!();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                label: const Text(
                  'Back to Claimed Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // extra safety
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white, // 👈 ensures icon + text are white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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