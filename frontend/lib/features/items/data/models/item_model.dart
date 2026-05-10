class ItemModel {
  // exact backend keys
  static const String keyId = 'id';
  static const String keyTitle = 'title';
  static const String keyDesc = 'description';
  static const String keyLocation = 'location';
  static const String keyImage = 'image_url';
  static const String keyStatus = 'status';
  static const String keyQuestion = 'verification_question';
  static const String keyAnswer = 'verification_answer';
  static const String keyDate = 'date_found';

  // Helper for "No Image" fallback
  static const String placeholderImage = "https://via.placeholder.com/400x200?text=No+Image+Available";
}