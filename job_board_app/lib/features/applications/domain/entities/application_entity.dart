import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_entity.freezed.dart';

@freezed
class ApplicationEntity with _$ApplicationEntity {
  const factory ApplicationEntity({
    required String id,
    required String jobId,
    required String userId,
    required String status,
    required DateTime appliedAt,
    String? cvUrl,
  }) = _ApplicationEntity;
}
