import '../../claims/data/model/claim_model.dart';

/// Extra fields for the admin "claim review" screen (mock only).
class AdminClaimReviewExtras {
  final String reviewCode;
  final String itemIdBadge;
  final String recoveredNote;
  final List<String> tags;
  final String claimantInitials;
  final String claimantName;
  final String claimantEmail;
  final String verifiedIdReference;
  final String evidenceQuestion1;
  final String evidenceAnswer1;
  final String evidenceQuestion2;
  final String evidenceAnswer2;
  final String securityProtocolText;

  const AdminClaimReviewExtras({
    required this.reviewCode,
    required this.itemIdBadge,
    required this.recoveredNote,
    required this.tags,
    required this.claimantInitials,
    required this.claimantName,
    required this.claimantEmail,
    required this.verifiedIdReference,
    required this.evidenceQuestion1,
    required this.evidenceAnswer1,
    required this.evidenceQuestion2,
    required this.evidenceAnswer2,
    required this.securityProtocolText,
  });
}

String _initials(String title) {
  final parts = title.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
  if (parts.isEmpty) return 'NA';
  if (parts.length == 1) {
    final w = parts[0];
    return w.length >= 2 ? w.substring(0, 2).toUpperCase() : '${w}X'.toUpperCase();
  }
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

/// Consistent mock review row — aligns with [claim.title] / [claim.description].
AdminClaimReviewExtras adminClaimReviewExtrasFor(Claim claim) {
  final idNum = int.tryParse(claim.id) ?? 0;
  final reviewCode = 'SH-${98 + idNum}';

  return AdminClaimReviewExtras(
    reviewCode: reviewCode,
    itemIdBadge: '${44020 + idNum}',
    recoveredNote:
        'Reported recovered near: ${claim.location}. Please verify claimant evidence before approving.',
    tags: [
      claim.category,
      if (claim.status.name == 'pending') 'Awaiting review',
      if (claim.status.name == 'approved') 'Previously cleared',
      if (claim.status.name == 'rejected') 'Previously denied',
    ],
    claimantInitials: _initials(claim.title),
    claimantName: 'Student claimant #${claim.id}',
    claimantEmail: 'claimant.${claim.id}@student.univ.edu.et',
    verifiedIdReference:
        '#${claim.id}-99281-${String.fromCharCode(65 + (idNum % 26))}',
    evidenceQuestion1: 'DESCRIBE ANY UNIQUE MARKS OR SCRATCHES.',
    evidenceAnswer1: claim.description.isNotEmpty
        ? claim.description
        : 'No additional marks noted in this submission.',
    evidenceQuestion2: 'LIST THE APPROXIMATE CONTENTS.',
    evidenceAnswer2:
        'Submitted details reference the item category (${claim.category}) and pickup context; confirm visually with the recovered item.',
    securityProtocolText:
        'Verify university ID matches registrar records before possession transfer. Retain denial notes for audits.',
  );
}
