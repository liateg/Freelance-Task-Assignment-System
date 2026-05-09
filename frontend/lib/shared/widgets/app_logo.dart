
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final bool showTagline;
  final double size;
  const AppLogo({
    super.key,
    this.showTagline = true,
    this.size=60,
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
            borderRadius: BorderRadius.circular(12)
          ),
          child:  Center(
            child: Image.asset('assets/images/img_2.png',
              width: 20,
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