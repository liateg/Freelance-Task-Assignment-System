
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final bool showTagline;
  final double size;
  const AppLogo({
    super.key,
    this.showTagline = true,
    this.size=80,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF1C3E1B),
            shape: BoxShape.circle,  // Makes it a circle
          ),
          child: const Center(
            child: Text(
              'RC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'ReClaim',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C3E1B),
          ),
        ),
        if (showTagline) ...[
          const SizedBox(height: 12),
          Text(
            'Reconnect people with their belongings\nthrough our curated digital concierge.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}