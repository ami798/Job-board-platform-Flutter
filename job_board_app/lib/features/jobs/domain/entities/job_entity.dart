import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_entity.freezed.dart';

@freezed
class JobEntity with _$JobEntity {
  const factory JobEntity({
    required String id,
    required String title,
    required String company,
    required String location,
    required String description,
    required String requirements,
    required String benefits,
    required double salary,
    required String employerId,
    required DateTime createdAt,
  }) = _JobEntity;
}
