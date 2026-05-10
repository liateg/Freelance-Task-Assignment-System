import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class ClaimCard extends StatelessWidget {
  final Map<String, dynamic> claim;
  final VoidCallback? onWithdraw;
  final VoidCallback? onTap;

  const ClaimCard({
    super.key,
    required this.claim,
    this.onWithdraw,
    this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return AppTheme.statusPendingLight;
      case 'APPROVED':
        return AppTheme.statusApprovedLight;
      case 'REJECTED':
        return AppTheme.statusRejectedLight;
      default:
        return AppTheme.statusPendingLight;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return const Color(0xFF2E7D32);
      case 'APPROVED':
        return AppTheme.primaryGreen;
      case 'REJECTED':
        return Colors.black;
      default:
        return const Color(0xFF2E7D32);
    }
  }

  String _getButtonText(String status) {
    if (status.toUpperCase() == 'PENDING') {
      return 'Withdraw';
    }
    return 'Delete';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = claim['imageUrl'] as String?;
    final status = (claim['status'] as String?) ?? 'Pending';
    final title = (claim['title'] as String?) ?? 'Untitled Claim';
    final description = (claim['description'] as String?) ?? '';
    final date =
        (claim['date'] as String?) ?? (claim['filedDate'] as String?) ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: imageUrl == null || imageUrl.isEmpty
                      ? Container(
                          color: AppTheme.grayBorder.withValues(alpha: 0.45),
                          child: const Icon(
                            Icons.image_outlined,
                            size: 44,
                            color: AppTheme.grayText,
                          ),
                        )
                      : Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(status),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: _getStatusTextColor(status),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: Color(0xFF5F6B66),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Filed on $date',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6E746F),
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: onWithdraw,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.grayBorder.withValues(
                        alpha: 0.9,
                      ),
                      foregroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _getButtonText(status),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
