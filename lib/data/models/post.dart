import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

enum PostType { observation, question, tip }

@freezed
abstract class Post with _$Post {
  const Post._();

  const factory Post({
    required String id,
    required String authorProfileId,
    required String authorDisplayName,
    required String village,
    required String district,
    required String contentText,
    required PostType postType,
    required int reportCount,
    required DateTime createdAt,
  }) = _Post;

  bool get isHidden => deriveIsHidden(reportCount);

  static bool deriveIsHidden(int reportCount) {
    return reportCount >= 3;
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
