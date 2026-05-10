import '../../enum/claim_status.dart';

class Claim {
  final String id;
  final String title;
  final String description;
  final String location;
  final ClaimStatus status;
  final String? imageUrl;
  final DateTime date;

  Claim({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    this.imageUrl,
    required this.date,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'Untitled Claim',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      status: _statusFromString(json['status'] as String?),
      imageUrl: json['imageUrl'] as String?,
      date: DateTime.parse(
        json['date'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  static ClaimStatus _statusFromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return ClaimStatus.approved;
      case 'rejected':
        return ClaimStatus.rejected;
      case 'pending':
      default:
        return ClaimStatus.pending;
    }
  }
}