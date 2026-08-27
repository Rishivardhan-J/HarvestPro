import 'package:freezed_annotation/freezed_annotation.dart';

part 'capture_artifact.freezed.dart';
part 'capture_artifact.g.dart';

enum CaptureType { photo, voiceNote, textNote }
enum SyncStatus { pending, synced, failed }

@freezed
abstract class CaptureArtifact with _$CaptureArtifact {
  const factory CaptureArtifact({
    required String id,
    required String farmerProfileId,
    required CaptureType type,
    String? localFilePath,
    String? textContent,
    @Default(SyncStatus.pending) SyncStatus syncStatus,
    @Default(0) int retryCount,
    required DateTime createdAt,
  }) = _CaptureArtifact;

  factory CaptureArtifact.fromJson(Map<String, dynamic> json) => _$CaptureArtifactFromJson(json);
}
