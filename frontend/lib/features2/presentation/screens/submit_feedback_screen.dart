import 'package:flutter/material.dart';

class SubmitFeedbackScreen extends StatefulWidget {
  const SubmitFeedbackScreen({super.key});

  @override
  State<SubmitFeedbackScreen> createState() => _SubmitFeedbackScreenState();
}

class _SubmitFeedbackScreenState extends State<SubmitFeedbackScreen> {

  static const Color kBg        = Color(0xFFFEF9F2);
  static const Color kHeaderBg  = Color(0xCCFEF9F2);
  static const Color kDarkGreen = Color(0xFF003925);
  static const Color kCardBg    = Color(0xFFF8F3EC);
  static const Color kInputBg   = Color(0xFFE6E2DB);
  static const Color kBorder    = Color(0x26C0C9C1);
  static const Color kTextDark  = Color(0xFF1D1C18);
  static const Color kTextBody  = Color(0xFF404943);
  static const Color kHint      = Color(0x99404943);
  static const Color kShadow    = Color(0x0F1D1C18);
  static const Color kError     = Color(0xFFD94040);

  int  _starRating   = 0;
  bool _starError    = false;
  bool _commentError = false;
  bool _submitted    = false;

  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }


  TextStyle _manrope({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = kTextDark,
    double height = 1.5,
    double letterSpacing = 0,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  void _onSubmit() {
    final bool noStar    = _starRating == 0;
    final bool noComment = _commentsController.text.trim().isEmpty;

    setState(() {
      _starError    = noStar;
      _commentError = noComment;
    });

    if (noStar || noComment) {
      final missing = <String>[];
      if (noStar)    missing.add('a star rating');
      if (noComment) missing.add('your comments');

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Please add ${missing.join(' and ')} before submitting.',
                  style: _manrope(size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: kError,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() => _submitted = true);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Thank you for your feedback!',
                style: _manrope(size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: kDarkGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _onStarTap(int index) {
    setState(() {
      _starRating = index + 1;
      _starError  = false;
      _submitted  = false;
    });
  }

  void _onCommentChanged(String _) {
    if (_commentError && _commentsController.text.trim().isNotEmpty) {
      setState(() => _commentError = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildItemCard(),
                      const SizedBox(height: 32),
                      _buildStarSection(),
                      const SizedBox(height: 32),
                      _buildCommentsSection(),
                      const SizedBox(height: 32),
                      _buildSubmitButton(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: kHeaderBg,
        boxShadow: [BoxShadow(color: kShadow, blurRadius: 32, offset: Offset(0, 12))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9999)),
                    ),
                  ),
                  child: const Icon(Icons.arrow_back, color: kDarkGreen, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Feedback & Ratings',
                style: _manrope(
                  size: 20,
                  weight: FontWeight.w600,
                  color: kDarkGreen,
                  height: 1.40,
                  letterSpacing: -0.50,
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const ShapeDecoration(
              color: kInputBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9999)),
              ),
            ),
            child: const Icon(Icons.person, color: kDarkGreen, size: 22),
          ),
        ],
      ),
    );
  }

  
  Widget _buildItemCard() {
    return Container(
      width: double.infinity,
      height: 125,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: kCardBg,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: kBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [BoxShadow(color: kShadow, blurRadius: 32, offset: Offset(0, 12))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: kInputBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Icon(Icons.image_outlined, color: Color(0xFF8A9490), size: 36),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kInputBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 120,
                  decoration: BoxDecoration(
                    color: kInputBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildStarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Your Rating',
              style: _manrope(
                size: 16,
                weight: FontWeight.w600,
                color: _starError ? kError : kTextDark,
              ),
            ),
            if (_starError) ...[
              const SizedBox(width: 8),
              Text(
                '— Please select a rating',
                style: _manrope(size: 13, color: kError),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: _starError
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
              : EdgeInsets.zero,
          decoration: _starError
              ? BoxDecoration(
                  border: Border.all(color: kError, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                  color: kError.withOpacity(0.05),
                )
              : const BoxDecoration(),
          child: Row(
            children: List.generate(5, (i) {
              final filled = i < _starRating;
              return GestureDetector(
                onTap: () => _onStarTap(i),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: filled ? kDarkGreen : (_starError ? kError : kHint),
                    size: 38,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }


  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Additional Comments',
              style: _manrope(
                size: 16,
                weight: FontWeight.w600,
                color: _commentError ? kError : kTextDark,
              ),
            ),
            if (_commentError) ...[
              const SizedBox(width: 8),
              Text(
                '— Required',
                style: _manrope(size: 13, color: kError),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: ShapeDecoration(
            color: kInputBg,
            shape: RoundedRectangleBorder(
              side: _commentError
                  ? const BorderSide(color: kError, width: 1.5)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [BoxShadow(color: kShadow, blurRadius: 32, offset: Offset(0, 12))],
          ),
          child: TextField(
            controller: _commentsController,
            onChanged: _onCommentChanged,
            minLines: 5,
            maxLines: 8,
            style: _manrope(size: 16, color: kTextBody),
            decoration: InputDecoration(
              hintText: 'Share your experience... (Optional)',
              hintStyle: _manrope(
                size: 16,
                color: _commentError ? kError.withOpacity(0.6) : kHint,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                top: 16, left: 16, right: 16, bottom: 88,
              ),
            ),
          ),
        ),
        if (_commentError) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.info_outline, color: kError, size: 14),
              const SizedBox(width: 4),
              Text(
                'Please share your experience before submitting.',
                style: _manrope(size: 12, color: kError),
              ),
            ],
          ),
        ],
      ],
    );
  }


  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.47, 1.47),
            end: Alignment(0.53, -0.47),
            colors: [Color(0xFF003925), Color(0xFF1D503A)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadows: const [BoxShadow(color: kShadow, blurRadius: 32, offset: Offset(0, 12))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _submitted ? null : _onSubmit,
            borderRadius: BorderRadius.circular(12),
            splashColor: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Text(
                _submitted ? 'Feedback Submitted ✓' : 'Submit Feedback',
                textAlign: TextAlign.center,
                style: _manrope(
                  size: 16,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}