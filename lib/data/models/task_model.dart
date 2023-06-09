class Task {
  final String? titleEs;
  final String? titleEn;
  final String? descriptionEs;
  final String? descriptionEn;
  final bool? isCompleted;
  final String? date;
  final String? userId;
  final String? id;

  Task({
    this.titleEs,
    this.titleEn,
    this.descriptionEs,
    this.descriptionEn,
    this.isCompleted,
    this.date,
    this.userId,
    this.id,
  });

  Task copyWith({
    String? titleEs,
    String? titleEn,
    String? descriptionEs,
    String? descriptionEn,
    bool? isCompleted,
    String? date,
    String? userId,
    String? id,
  }) {
    return Task(
      titleEs: titleEs ?? this.titleEs,
      titleEn: titleEn ?? this.titleEn,
      descriptionEs: descriptionEs ?? this.descriptionEs,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  factory Task.fromJson(dynamic json, String id) => Task(
    titleEs: json['title_es'],
    titleEn: json['title_en'],
    descriptionEs: json['description_es'],
    descriptionEn: json['description_en'],
    isCompleted: json['is_completed'],
    date: json['date'],
    userId: json['user_id'],
    id: id,
  );

  Map<String, dynamic> toJson() {
    return {
      'title_es': titleEs,
      'title_en': titleEn,
      'description_es': descriptionEs,
      'description_en': descriptionEn,
      'is_completed': isCompleted ?? false,
      'date': date,
      'user_id': userId,
    };
  }
}