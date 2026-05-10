import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class AdminClaimCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String date;
  final VoidCallback? onPressed;

  const AdminClaimCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.date,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.adminCardBackground,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            child: imageUrl.isEmpty
                ? Container(
                    height: 240,
                    width: double.infinity,
                    color: const Color(0xFFE6E2DB),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: Color(0xFF77756F),
                    ),
                  )
                : Image.network(
                    imageUrl,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 240,
                      width: double.infinity,
                      color: const Color(0xFFE6E2DB),
                      child: const Icon(
                        Icons.broken_image_outlined,
                        size: 48,
                        color: Color(0xFF77756F),
                      ),
                    ),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Text(
                  date.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: AppTheme.adminLocationGreen,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: AppTheme.adminLocationGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

               
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.adminActionGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Claim Review",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}