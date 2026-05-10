import 'package:flutter/material.dart';

class FeedbackSuccessScreen extends StatelessWidget {
  const FeedbackSuccessScreen({super.key});


  static const Color kBg           = Color(0xFFFEF9F2);
  static const Color kDarkGreen    = Color(0xFF003925);
  static const Color kMidGreen     = Color(0xFF1D503A);
  static const Color kTextBody     = Color(0xFF404943);
  static const Color kRingOuter    = Color(0x4C9DD2B5); 
  static const Color kCircleBg     = Color(0xFFF8F3EC);
  static const Color kCircleBorder = Color(0x26C0C9C1);
  static const Color kUnderline    = Color(0xFF9DD2B5);
  static const Color kShadow       = Color(0x0F1D1C18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  _buildCheckIllustration(),

                  const SizedBox(height: 32),

                  const Text(
                    'Feedback Submitted',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kMidGreen,
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      letterSpacing: -0.40,
                    ),
                  ),

                  const SizedBox(height: 16),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: const Text(
                      'Thank you for helping our community stay safe\nand connected. Your input is invaluable to us.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextBody,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.63,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

    
                  _buildPrimaryButton(
                    label: 'Back to Claims',
                    onTap: () => Navigator.maybePop(context),
                  ),

                  const SizedBox(height: 16),

                  
                  _buildSecondaryLink(
                    label: 'Return to Dashboard',
                    onTap: () {
                     
                      Navigator.pushNamedAndRemoveUntil(
                        context, 
                        '/dashboard', 
                        (route) => false,
                      );
                    },
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckIllustration() {
    return SizedBox(
      width: 192,
      height: 192,
      child: Stack(
        alignment: Alignment.center,
        children: [
         
          Container(
            width: 192,
            height: 192,
            decoration: const BoxDecoration(
              color: kRingOuter,
              shape: BoxShape.circle,
            ),
          ),


          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kCircleBg,
              border: Border.all(color: kCircleBorder, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 32,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment(0.00, 1.00),
                  end: Alignment(1.00, 0.00),
                  colors: [Color(0x0C003925), Color(0x00003925)],
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: kDarkGreen,
                size: 52,
              ),
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.47, 1.47),
          end: Alignment(0.53, -0.47),
          colors: [kDarkGreen, kMidGreen],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(color: kShadow, blurRadius: 32, offset: Offset(0, 12)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 1.56,
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _buildSecondaryLink({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: kUnderline, width: 2),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kDarkGreen,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.50,
            ),
          ),
        ),
      ),
    );
  }
}