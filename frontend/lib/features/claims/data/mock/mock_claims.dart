import '../model/claim_model.dart';

final List<Claim> mockClaims = [
  Claim(
    id: '1',
    title: 'Broken Laptop',
    description: 'The screen is cracked after falling.',
    imageUrl: 'https://picsum.photos/400/250?random=1',
    status: Claim.fromJson({
      "id": "x",
      "title": "x",
      "description": "x",
      "status": "pending",
      "date": DateTime.now().toIso8601String(),
    }).status,
    date: DateTime.now(),
  ),
  Claim(
    id: '2',
    title: 'Lost ID Card',
    description: 'I misplaced my student ID card.',
    imageUrl: 'https://picsum.photos/400/250?random=2',
    status: Claim.fromJson({
      "id": "x",
      "title": "x",
      "description": "x",
      "status": "approved",
      "date": DateTime.now().toIso8601String(),
    }).status,
    date: DateTime.now(),
  ),
  Claim(
    id: '3',
    title: 'Transport Refund',
    description: 'Requesting refund for bus fee.',
    imageUrl: 'https://picsum.photos/400/250?random=3',
    status: Claim.fromJson({
      "id": "x",
      "title": "x",
      "description": "x",
      "status": "rejected",
      "date": DateTime.now().toIso8601String(),
    }).status,
    date: DateTime.now(),
  ),
];
