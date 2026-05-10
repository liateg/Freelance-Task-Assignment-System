final List<Map<String, dynamic>> mockItems = [
  {
    'id': '1',
    'title': 'Silver MacBook Air',
    'location': 'Central Library, 2nd Floor',
    'description': 'Found near the reading area with a gray sleeve.',
    'category': 'Electronics',
    'status': 'available',
    'date_found': 'May 8, 2026',
    'verification_question': 'What sticker is on the laptop cover?',
    'verification_answer': 'Blue star',
    'image_url': 'https://picsum.photos/id/180/1200/800',
  },
  {
    'id': '2',
    'title': 'Black Backpack',
    'location': 'Science Building Lobby',
    'description': 'Backpack with notebooks and a water bottle.',
    'category': 'Accessories',
    'status': 'pending',
    'date_found': 'May 9, 2026',
    'verification_question': 'What brand is the backpack?',
    'verification_answer': 'JanSport',
    'image_url': 'https://picsum.photos/id/1062/1200/800',
  },
  {
    'id': '3',
    'title': 'Gold Bracelet',
    'location': 'Cafeteria',
    'description': 'Small gold bracelet found near table 8.',
    'category': 'Accessories',
    'status': 'available',
    'date_found': 'May 10, 2026',
    'verification_question': 'What symbol is engraved on it?',
    'verification_answer': 'Heart',
    'image_url': 'https://picsum.photos/id/791/1200/800',
  },
];

void addMockItem({
  required String title,
  required String location,
  required String description,
  required String verificationQuestion,
  required String verificationAnswer,
  String category = 'Other',
  String imageUrl = 'https://picsum.photos/1200/800',
}) {
  mockItems.insert(0, {
    'id': DateTime.now().millisecondsSinceEpoch.toString(),
    'title': title,
    'location': location,
    'description': description,
    'category': category,
    'status': 'available',
    'date_found': 'Today',
    'verification_question': verificationQuestion,
    'verification_answer': verificationAnswer,
    'image_url': imageUrl,
  });
}

bool updateMockItem({
  required String id,
  required String title,
  required String location,
  String? description,
  String? category,
  String? verificationQuestion,
  String? verificationAnswer,
  String? status,
  String? imageUrl,
}) {
  final index = mockItems.indexWhere((item) => item['id'] == id);
  if (index == -1) return false;

  mockItems[index] = {
    ...mockItems[index],
    'title': title,
    'location': location,
    'description': description ?? mockItems[index]['description'],
    'category': category ?? mockItems[index]['category'],
    'verification_question':
        verificationQuestion ?? mockItems[index]['verification_question'],
    'verification_answer':
        verificationAnswer ?? mockItems[index]['verification_answer'],
    'status': status ?? mockItems[index]['status'],
    'image_url': imageUrl ?? mockItems[index]['image_url'],
  };
  return true;
}

bool removeMockItem(String id) {
  final before = mockItems.length;
  mockItems.removeWhere((item) => item['id'] == id);
  return mockItems.length < before;
}

bool submitClaimForItem({required String id, required String answer}) {
  final index = mockItems.indexWhere((item) => item['id'] == id);
  if (index == -1) return false;
  final expected = (mockItems[index]['verification_answer'] as String?) ?? '';
  if (expected.trim().toLowerCase() != answer.trim().toLowerCase()) {
    return false;
  }
  mockItems[index] = {
    ...mockItems[index],
    'status': 'pending',
  };
  return true;
}