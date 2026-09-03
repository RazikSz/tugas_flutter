// Model untuk Data Pelatihan (Trainings) dan Batch Pelatihan (Batches)

class TrainingModel {
  final int? id;
  final String? title;
  final String? description;

  TrainingModel({this.id, this.title, this.description});

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
  };
}

class BatchModel {
  final int? id;
  final int? batchKe;
  final String? startDate;
  final String? endDate;
  final List<TrainingModel>? trainings;

  BatchModel({
    this.id,
    this.batchKe,
    this.startDate,
    this.endDate,
    this.trainings,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: (json['id'] as num?)?.toInt(),
      batchKe: (json['batch_ke'] as num?)?.toInt(),
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      trainings: (json['trainings'] as List<dynamic>?)
          ?.map((e) => TrainingModel.fromJson(
              e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'batch_ke': batchKe,
    'start_date': startDate,
    'end_date': endDate,
    'trainings': trainings?.map((e) => e.toJson()).toList(),
  };
}
