import 'package:flutter/material.dart';

enum FeedbackReportStatus {
  pending,
  reviewed,
}

extension FeedbackReportStatusX on FeedbackReportStatus {
  String get label {
    switch (this) {
      case FeedbackReportStatus.pending:
        return 'Pending';
      case FeedbackReportStatus.reviewed:
        return 'Reviewed';
    }
  }

  Color get chipBg {
    switch (this) {
      case FeedbackReportStatus.pending:
        return const Color(0xFFE6E2DB);
      case FeedbackReportStatus.reviewed:
        return const Color(0xFFD2E8D9);
    }
  }

  Color get chipText {
    switch (this) {
      case FeedbackReportStatus.pending:
        return const Color(0xFF404943);
      case FeedbackReportStatus.reviewed:
        return const Color(0xFF55695D);
    }
  }
}

@immutable
class FeedbackReportMock {
  final String id;
  final String reporterLabel; // e.g. "Student #8821"
  final String submittedLabel; // e.g. "Today, 10:42 AM"
  final FeedbackReportStatus status;
  final String title;
  final String description;
  final List<String> tags;
  final String? reviewer;
  final String? moderationNote;
  final String? moderationNoteTimestamp;

  const FeedbackReportMock({
    required this.id,
    required this.reporterLabel,
    required this.submittedLabel,
    required this.status,
    required this.title,
    required this.description,
    required this.tags,
    this.reviewer,
    this.moderationNote,
    this.moderationNoteTimestamp,
  });
}

const List<FeedbackReportMock> kMockFeedbackReports = [
  FeedbackReportMock(
    id: 'FB-2023-8821',
    reporterLabel: 'Student #8821',
    submittedLabel: 'Today, 10:42 AM',
    status: FeedbackReportStatus.pending,
    title: 'Return process delay',
    description:
        '“The process was okay, but finding my water bottle took a bit longer than expected at the desk.”',
    tags: ['UX/UI', 'Service'],
  ),
  FeedbackReportMock(
    id: 'FB-2023-4290',
    reporterLabel: 'Student #4290',
    submittedLabel: 'Yesterday, 4:15 PM',
    status: FeedbackReportStatus.reviewed,
    title: 'Fast and polite support',
    description:
        '“Incredibly fast and polite! Saved me so much stress before my midterm.”',
    tags: ['Positive', 'Service'],
    reviewer: 'Sarah J.',
    moderationNoteTimestamp: 'Oct 25, 2023 · 09:14 AM',
    moderationNote:
        'Feedback logged and forwarded to the product design team (Ticket #DS‑1092). No direct user follow‑up required at this time.',
  ),
  FeedbackReportMock(
    id: 'FB-2023-9012',
    reporterLabel: 'Student #9012',
    submittedLabel: 'Oct 24, 2:30 PM',
    status: FeedbackReportStatus.pending,
    title: 'No one at desk',
    description:
        '“I was told my laptop was here but no one could find it when I arrived. Very frustrating.”',
    tags: ['Service', 'Urgent'],
  ),
  FeedbackReportMock(
    id: 'FB-2023-8920',
    reporterLabel: 'Student #8920',
    submittedLabel: 'Oct 22, 11:05 AM',
    status: FeedbackReportStatus.reviewed,
    title: 'Navigation confusion',
    description:
        '“Since the last update, the button to ‘Add New Item’ seems to have moved. It took me a while to find.”',
    tags: ['UX/UI', 'Feature Request', 'Mobile App'],
    reviewer: 'Sarah J.',
    moderationNoteTimestamp: 'Oct 25, 2023 · 09:14 AM',
    moderationNote:
        'User’s point about placement is valid; the latest update moved it to prioritize search. We will consider adding a FAB for quick add in the next release.',
  ),
];

