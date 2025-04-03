class Announcement {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime? visibleFrom;
  final DateTime? visibleTo;
  final bool isActive;
  final String createdBy;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.visibleFrom,
    this.visibleTo,
    required this.isActive,
    required this.createdBy,
  });

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      imageUrl: map['image_url'],
      visibleFrom: map['visible_from'] != null
          ? DateTime.parse(map['visible_from'])
          : null,
      visibleTo:
          map['visible_to'] != null ? DateTime.parse(map['visible_to']) : null,
      isActive: map['is_active'],
      createdBy: map['created_by'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'visible_from': visibleFrom?.toIso8601String(),
      'visible_to': visibleTo?.toIso8601String(),
      'is_active': isActive,
      'created_by': createdBy,
    };
  }
}
